# ============================================
#   Universal C Project Template - Makefile
# ============================================

# --- Load build metadata ---
-include .buildinfo

# --- Defaults (if not set in .buildinfo) ---
PROJECT_NAME   ?= Generic C Project
PROJECT_BIN    ?= app
PROJECT_VER    ?= 0.1.0
PROJECT_AUTHOR ?= Unknown
BUILD_MODE     ?= release
CC             ?= gcc
CFLAGS_BASE    := -Wall -Wextra -Iinclude

# --- Compiler flags based on build mode ---
ifeq ($(BUILD_MODE),debug)
    CFLAGS := $(CFLAGS_BASE) -g -DDEBUG
else ifeq ($(BUILD_MODE),release)
    CFLAGS := $(CFLAGS_BASE) -O2
else
    CFLAGS := $(CFLAGS_BASE)
endif

# --- Directories ---
SRC_DIR  := src
OBJ_DIR  := build
BIN_DIR  := bin
TARGET   := $(BIN_DIR)/$(PROJECT_BIN)

# --- Files ---
SRC          := $(wildcard $(SRC_DIR)/*.c)
OBJ          := $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRC))
SRC_NO_MAIN  := $(filter-out $(SRC_DIR)/main.c, $(SRC))
OBJ_NO_MAIN  := $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRC_NO_MAIN))

TEST_DIR := tests
TEST_SRC := $(wildcard $(TEST_DIR)/*.c)
TEST_OBJ := $(patsubst $(TEST_DIR)/%.c, $(OBJ_DIR)/%.o, $(TEST_SRC))
TEST_BIN := $(BIN_DIR)/test_runner

# --- Colors ---
BOLD   := $(shell tput bold)
RESET  := $(shell tput sgr0)
CYAN   := $(shell tput setaf 6)
YELLOW := $(shell tput setaf 3)
GREEN  := $(shell tput setaf 2)
GRAY   := $(shell tput setaf 8)

# ============================================
#   Default Build
# ============================================

all: header dirs $(TARGET)
	@echo "$(GREEN)Build complete.$(RESET)"

$(TARGET): $(OBJ)
	@echo "$(CYAN)Linking:$(RESET) $(notdir $@)"
	@$(CC) $(OBJ) -o $(TARGET)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@echo "$(YELLOW)Compiling:$(RESET) $(notdir $<)"
	@$(CC) $(CFLAGS) -c $< -o $@

dirs:
	@mkdir -p $(OBJ_DIR) $(BIN_DIR)

# ============================================
#   Run Program
# ============================================

run: all
	@echo ""
	@echo "$(CYAN)Running:$(RESET) $(notdir $(TARGET))"
	@echo "$(GRAY)----------------------------------------$(RESET)"
	@./$(TARGET)
	@echo "$(GRAY)----------------------------------------$(RESET)"

# ============================================
#   Unit Tests
# ============================================

test: header dirs $(TEST_BIN)
	@echo "$(CYAN)Running tests...$(RESET)"
	@echo "$(GRAY)----------------------------------------$(RESET)"
	@./$(TEST_BIN)
	@echo "$(GRAY)----------------------------------------$(RESET)"
	@echo "$(GREEN)All tests completed.$(RESET)"

$(TEST_BIN): $(OBJ_NO_MAIN) $(TEST_OBJ)
	@echo "$(CYAN)Linking tests:$(RESET) $(notdir $@)"
	@$(CC) $(OBJ_NO_MAIN) $(TEST_OBJ) -o $(TEST_BIN)

$(OBJ_DIR)/%.o: $(TEST_DIR)/%.c
	@echo "$(YELLOW)Compiling test:$(RESET) $(notdir $<)"
	@$(CC) $(CFLAGS) -c $< -o $@

# ============================================
#   Clean
# ============================================

clean:
	@echo ""
	@echo "$(CYAN)========================================$(RESET)"
	@echo "$(CYAN)   Cleaning Project: $(PROJECT_NAME)$(RESET)"
	@echo "$(CYAN)========================================$(RESET)"
	@if [ -d "$(OBJ_DIR)" ] || [ -d "$(BIN_DIR)" ]; then \
		echo "$(YELLOW)Removing build artifacts...$(RESET)"; \
		rm -rf $(OBJ_DIR) $(BIN_DIR); \
		echo "$(GREEN)✔ Clean complete.$(RESET)"; \
	else \
		echo "$(GRAY)Nothing to clean — project is already clean.$(RESET)"; \
	fi
	@echo ""

# ============================================
#   Header Output
# ============================================

header:
	@echo ""
	@echo "$(BOLD)========================================$(RESET)"
	@echo "$(BOLD)   $(PROJECT_NAME)$(RESET)"
	@echo "$(GRAY)   Version: $(PROJECT_VER) | Mode: $(BUILD_MODE)$(RESET)"
	@echo "$(GRAY)   Author:  $(PROJECT_AUTHOR)$(RESET)"
	@echo "$(BOLD)========================================$(RESET)"
	@echo ""

.PHONY: all clean run test dirs header

