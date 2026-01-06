#!/bin/bash
set -e

# ============================================
# Configuration - SSH User Credentials
# ============================================
SSH_USERNAME="whizadminuser"
SSH_PASSWORD="WhizAdminUser@123"
SSH_PORT="22"

# ============================================
# Configuration - Key Encryption (AES-128-CBC)
# ============================================
# NOTE: AES-128 requires a 16-byte key and 16-byte IV.
# These values are 16 ASCII chars each (16 bytes).
SECRET_KEY="initvector123456"
IV="passwordpassword"

# ============================================
# Task 1: Install Dependencies
# ============================================
install_dependencies() {
  echo "[*] Updating system packages..."
  sudo apt update -y
  # openssl + xxd (vim-common) are required for key encryption
  sudo apt install -y git curl ca-certificates gnupg lsb-release openssh-server openssl vim-common

  echo "[*] Installing Docker..."
  # Add Docker GPG key if not already present
  if [ ! -f /usr/share/keyrings/docker.gpg ]; then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg
  fi

  # Add Docker repository if not already present
  if [ ! -f /etc/apt/sources.list.d/docker.list ]; then
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
  fi

  sudo apt update -y
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

  echo "[+] Dependencies installed successfully!"
}

# ============================================
# Task 2.5: Ensure Docker Daemon Running
# ============================================
ensure_docker_running() {
  echo "[*] Ensuring Docker daemon is running..."
  if systemctl is-active --quiet docker; then
    echo "[*] Docker is already active."
    return
  fi

  sudo systemctl start docker || {
    echo "[!] Failed to start docker service. Please check system logs." >&2
    exit 1
  }

  sudo systemctl enable docker >/dev/null 2>&1 || true

  if systemctl is-active --quiet docker; then
    echo "[+] Docker started successfully."
  else
    echo "[!] Docker is not active after start attempt." >&2
    exit 1
  fi
}

# ============================================
# Task 2: Setup SSH and Create User
# ============================================
setup_ssh_user() {
  echo "[*] Setting up SSH and creating user..."

  # Create user if it doesn't exist
  if ! id "$SSH_USERNAME" &>/dev/null; then
    sudo useradd -m -s /bin/bash "$SSH_USERNAME"
    echo "[+] User '$SSH_USERNAME' created."
  else
    echo "[*] User '$SSH_USERNAME' already exists."
  fi

  # Set the password for the user
  echo "$SSH_USERNAME:$SSH_PASSWORD" | sudo chpasswd
  echo "[+] Password set for user '$SSH_USERNAME'."

  # Ensure SSH service is enabled and running
  sudo systemctl enable ssh
  sudo systemctl start ssh

  # Configure SSH to allow password authentication
  sudo sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
  sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

  # Ensure SSH listens on desired port
  sudo sed -i "s/^#Port .*/Port $SSH_PORT/" /etc/ssh/sshd_config
  sudo sed -i "s/^Port .*/Port $SSH_PORT/" /etc/ssh/sshd_config
  if ! grep -q "^Port $SSH_PORT" /etc/ssh/sshd_config; then
    echo "Port $SSH_PORT" | sudo tee -a /etc/ssh/sshd_config >/dev/null
  fi

  # Restart SSH to apply changes
  sudo systemctl restart ssh

  echo "[+] SSH configured on port $SSH_PORT with password authentication enabled."
  echo "[+] Access credentials:"
  echo "    Username: $SSH_USERNAME"
  echo "    Password: $SSH_PASSWORD"
}

# ============================================
# Task 3: Generate Keys
# ============================================
generate_key() {
  local static1=$1
  local static2=$2
  local rand1=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
  local rand2=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
  local rand3=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
  echo "${rand1}${static1}${rand2}${static2}${rand3}"
}

# Encrypt key using AES-128-CBC with padding and return hex string (no newlines)
encrypt_key() {
  local plaintext="$1"

  # AES-128 expects 16-byte key and 16-byte IV (32 hex chars each).
  # If SECRET_KEY/IV are longer, OpenSSL ignores the excess; we truncate to avoid warnings.
  local key_hex
  local iv_hex
  key_hex="$(printf "%s" "$SECRET_KEY" | xxd -p | tr -d '\n' | cut -c1-32)"
  iv_hex="$(printf "%s" "$IV" | xxd -p | tr -d '\n' | cut -c1-32)"

  printf "%s" "$plaintext" | openssl enc -aes-128-cbc \
    -K "$key_hex" \
    -iv "$iv_hex" | xxd -p | tr -d '\n'
}

generate_all_keys() {
  echo "[*] Generating keys..."

  sudo mkdir -p "$KEY_DIR"

  # Generate plaintext keys first so we can keep a backup before encrypting.
  pkey1=$(generate_key "Xk4mPv9Q" "rW7nBz3J")
  pkey2=$(generate_key "Hf6yLc2T" "dS8xKg5V")
  pkey3=$(generate_key "Nq1wRj7M" "pU4bYe9A")
  pkey4=$(generate_key "Zv3tDh8C" "mF6sXl2G")
  pkey5=$(generate_key "Ew5rNp1K" "jB9cQy4H")
  pkey6=$(generate_key "Lx7gTz3W" "vD2mSf8R")
  pkey7=$(generate_key "Yb4kJn6P" "qA9wCe1U")
  pkey8=$(generate_key "Gt8vMx2L" "hK5rZd7N")
  pkey9=$(generate_key "Fs3pYc9B" "tJ6nWq4X")
  pkey10=$(generate_key "Rd1mHv7E" "aP8bLk3S")

  # Encrypt keys (hex) for use by the containers.
  key1=$(encrypt_key "$pkey1")
  key2=$(encrypt_key "$pkey2")
  key3=$(encrypt_key "$pkey3")
  key4=$(encrypt_key "$pkey4")
  key5=$(encrypt_key "$pkey5")
  key6=$(encrypt_key "$pkey6")
  key7=$(encrypt_key "$pkey7")
  key8=$(encrypt_key "$pkey8")
  key9=$(encrypt_key "$pkey9")
  key10=$(encrypt_key "$pkey10")

  # Backup / comparison file for development: plaintext + encrypted side-by-side.
  # Format: TSV with header columns: CHALLENGE, PLAINTEXT, ENCRYPTED_HEX
  # Lock it down to the current user by default.
  sudo tee "$KEY_DIR/keys.txt" > /dev/null << EOF
CHALLENGE       PLAINTEXT       ENCRYPTED_HEX
KEY1    $pkey1  $key1
KEY2    $pkey2  $key2
KEY3    $pkey3  $key3
KEY4    $pkey4  $key4
KEY5    $pkey5  $key5
KEY6    $pkey6  $key6
KEY7    $pkey7  $key7
KEY8    $pkey8  $key8
KEY9    $pkey9  $key9
KEY10   $pkey10 $key10
EOF
  sudo chmod 600 "$KEY_DIR/keys.txt" 2>/dev/null || true

  # Write keys to well-known paths for container mounts
  sudo echo "$key1"  > "$KEY_DIR/key1.key"
  sudo echo "$key2"  > "$KEY_DIR/key2.key"
  sudo echo "$key3"  > "$KEY_DIR/key3.key"
  sudo echo "$key4"  > "$KEY_DIR/key4.key"
  sudo echo "$key5"  > "$KEY_DIR/key5.key"
  sudo echo "$key6"  > "$KEY_DIR/key6.key"
  sudo echo "$key7"  > "$KEY_DIR/key7.key"
  sudo echo "$key8"  > "$KEY_DIR/key8.key"
  sudo echo "$key9"  > "$KEY_DIR/key9.key"
  sudo echo "$key10" > "$KEY_DIR/key10.key"

  echo "[+] Key comparison table (plaintext + encrypted) saved to: $KEY_DIR/keys.txt"
  echo "[+] 10 keys generated, encrypted (AES-128-CBC), and saved under $KEY_DIR/*.key"

  echo "KEY1: $pkey1" > web_page/src/admin/key1.txt
  echo "KEY2: $pkey2" > web_page/src/login/key2.txt
  echo "KEY3: $pkey3" > web_page/src/credentials/key3.txt
  echo "Disallow: /ftp KEY4: $pkey4" > web_page/src/robots.txt
  echo "KEY5: $pkey5" > ssh_machine/vm1/key5.txt
  echo "KEY6: $pkey6" > ssh_machine/vm2/key6.txt
  echo "KEY7: $pkey7" > ssh_machine/vm3/key7.txt
  echo "KEY8: $pkey8" > ssh_machine/vm1/key8.txt
  echo "KEY9: $pkey9" > ssh_machine/vm2/key9.txt
  echo "KEY10: $pkey10" > ssh_machine/vm3/key10.txt

  echo "[+] Keys saved to respective files"
}

# ============================================
# Task 4: Start Docker Containers
# ============================================
start_containers() {
  echo "[*] Starting Docker containers..."
  if command -v docker-compose >/dev/null 2>&1; then
    dc="docker-compose"
  else
    dc="docker compose"
  fi
  $dc down 2>/dev/null || true
  $dc up --build -d
  echo "[+] Docker containers started!"
}

# ============================================
# Main Execution
# ============================================
main() {
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  KEY_DIR="$SCRIPT_DIR/keys"

  echo "=========================================="
  echo "  IntoTheUpsideDown Setup Script"
  echo "=========================================="

  install_dependencies
  ensure_docker_running
  setup_ssh_user
  generate_all_keys
  start_containers

  echo ""
  echo "=========================================="
  echo "  Setup Complete!"
  echo "=========================================="
  echo ""
}

main
