# Engineering Crawler

[![Built on crawl4ai](https://img.shields.io/badge/Built%20on-crawl4ai-blue)](https://github.com/unclecode/crawl4ai)
[![For Engineers](https://img.shields.io/badge/For-Engineers-green)]()
[![Python](https://img.shields.io/badge/Python-3.11+-blue)]()
[![Platform](https://img.shields.io/badge/Platform-Windows-lightgrey)]()
[![AI](https://img.shields.io/badge/AI-Gemini%202.5-orange)]()

> **🔧 Specialized Fork**: This is a purpose-built project management tool for engineering documentation workflows, built on top of [crawl4ai](https://github.com/unclecode/crawl4ai). It transforms general web crawling into systematic documentation workflows for technical professionals.

**What makes this different:** While crawl4ai is an excellent general-purpose web crawling library, Engineering Crawler adds project management, hierarchical organization, interactive workflows, and AI-enhanced document processing specifically for engineering documentation needs.

## Features

✅ **Interactive CLI** - Prompts for project, category, and URL with smart defaults  
✅ **Project Management** - Hierarchical organization (project/category structure)  
✅ **Single & Deep Crawling** - Crawl individual pages or follow links automatically  
✅ **Smart Memory** - Remembers your last project, category, and URL  
✅ **File Combining** - Merge all crawled files into one unified document  
✅ **AI Cleanup** - Optional Gemini Flash integration for document structure improvement  
✅ **UV Integration** - Uses UV for isolated Python environment  
✅ **Windows Optimized** - Works seamlessly in PowerShell and VS Code  

## Quick Start

### 1. One-time Setup
```powershell
PS> .\setup_engcrawl.bat
```

### 2. Daily Usage
```powershell
PS> .\run_engcrawl.bat
```

### 3. Interactive Session
```
Project Name? [your_project]: 
Category? [specs]: 
URL? [https://example.com/docs]: 
Deep crawl (follow links)? [y/N]: y

[DEEP CRAWLING] https://example.com/docs into your_project/specs (max 10 pages, depth 2)
[SUCCESS] Page 1: https://example.com/docs
[SUCCESS] Page 2: https://example.com/docs/installation
[SUCCESS] Page 3: https://example.com/docs/api

Combine all files into one document? [y/N]: y
Use AI cleanup (requires GEMINI_API_KEY)? [y/N]: y

[COMBINING] Found 3 files to combine...
  ✓ Added: page_01_docs.md
  ✓ Added: page_02_installation.md  
  ✓ Added: page_03_api.md
[SUCCESS] Combined file created: specs_combined.md
[AI CLEANUP] Using Gemini 2.5 Flash Lite to improve document structure...
[SUCCESS] AI-cleaned version saved: specs_combined_cleaned.md
```

## Project Structure

```
engineering_projects/
├── your_project/
│   ├── specs/
│   │   ├── pages/                    # Individual page files
│   │   │   ├── page_01_overview.md
│   │   │   ├── page_02_requirements.md
│   │   │   └── page_03_installation.md
│   │   ├── specs_combined.md         # Combined file with TOC
│   │   ├── specs_combined_cleaned.md # AI-cleaned version
│   │   ├── .category.yml
│   │   └── crawl.log
│   ├── design_references/
│   │   ├── pages/
│   │   └── crawl.log
│   └── .project.yml
└── .engcrawl_state.json
```

## Crawling Modes

### Single Page Crawling
- **What**: Crawls only the specific URL provided
- **When**: Use for individual documents, specific pages
- **How**: Answer "N" to "Deep crawl (follow links)?"

### Deep Crawling  
- **What**: Follows links to crawl up to 50 related pages, 2 levels deep
- **When**: Use for documentation sites, tutorials, comprehensive content
- **How**: Answer "y" to "Deep crawl (follow links)?"
- **Output**: Multiple files in `pages/` folder named `page_01_xxx.md`, `page_02_xxx.md`, etc.

## File Combining & AI Cleanup

### Combining Files
After crawling, you can merge all markdown files in a category into one unified document:

**Interactive Mode**: Answer "y" to "Combine all files into one document?"

**Command Line**:
```powershell
PS> uv run python engcrawl combine my_project specs
```

**Output**: Creates `specs_combined.md` with table of contents and navigation links

### AI Cleanup (Optional)
Uses Google's Gemini 2.5 Flash Lite to improve document structure while preserving all technical content:

**Setup**:
```powershell
# 1. Get API key from https://aistudio.google.com/app/apikey

# 2. Option A: Create .env file (recommended)
PS> copy .env.example .env
# Edit .env and add: GEMINI_API_KEY=your_api_key_here

# 2. Option B: Set environment variable
PS> set GEMINI_API_KEY=your_api_key_here

# 3. Install Google AI SDK (optional during setup)
PS> uv add google-generativeai
```

**What AI Cleanup Does**:
- ✅ Fixes markdown formatting (headers, lists, tables)
- ✅ Improves section organization and hierarchy  
- ✅ Removes duplicate or redundant content
- ✅ Ensures consistent heading levels
- ✅ Preserves table of contents and navigation links
- ✅ **Preserves ALL technical details, specs, and code examples**

**Usage**:
```powershell
# With cleanup
PS> uv run python engcrawl combine my_project specs --cleanup

# Interactive mode prompts you automatically
```

### Check the latets Gemini Cost [here](https://ai.google.dev/gemini-api/docs/pricing): 

Cost calculation is based on the following formula and pricing:
- **Input Price:** $0.10 per 1 million tokens
- **Output Price:** $0.50 per 1 million tokens
- **Formula:** `Total Cost = (Input_Tokens / 1,000,000 * $0.10) + (Output_Tokens / 1,000,000 * $0.50)`

| Scenario | Document Size | Est. Input Tokens | Est. Output Tokens (for Summarization) | Estimated Total Cost |
| :--- | :--- | :--- | :--- | :--- |
| **A: Single Technical Paper** | A 15-page paper (~6,000 words) | ~8,000 | ~800 | **~$0.0011** |
| **B: Medium Documentation (pyRevit)** | 50 pages (~50,000 words) | ~66,500 | ~6,650 | **~$0.0093** |
| **C: Large Design Manual** | A 300-page manual (~450,000 words) | ~600,000 | ~60,000 | **~$0.0850** |

## Configuration Files

### Project Configuration (`.project.yml`)
```yaml
name: your_project
created: '2025-07-05T10:30:00'
description: 'Engineering project: your_project'
default_settings:
  output_format: markdown
  verbose: true
  headless: true
  delay_before_return_html: 8
  wait_for_images: true
  simulate_user: true
  override_navigator: true
  page_timeout: 30000
  max_depth: 2
  max_pages: 50
```

### Category Configuration (`.category.yml`)
```yaml
settings:
  delay_before_return_html: 15  # Override for slow-loading sites
  css_selector: '.main-content'  # Focus on specific content areas
```

## Command Reference

### Interactive Mode (Recommended)
```powershell
PS> .\run_engcrawl.bat
```

### Command Line Mode
```powershell
# Initialize new project
PS> uv run python engcrawl init my_project

# Single crawl
PS> uv run python engcrawl crawl my_project docs https://example.com

# List projects
PS> uv run python engcrawl list

# List categories in project
PS> uv run python engcrawl list my_project

# Configure category settings
PS> uv run python engcrawl config my_project docs --delay 10 --css-selector ".content"

# Combine files into one document
PS> uv run python engcrawl combine my_project docs

# Combine with AI cleanup
PS> uv run python engcrawl combine my_project docs --cleanup
```

## VS Code Integration

### **Quick Setup** (Recommended)
```powershell
PS> .\setup_vscode.bat
```

### **Manual Setup**
Add to `.vscode/tasks.json`:
```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Run Engineering Crawler",
            "type": "shell",
            "command": ".\\\\run_engcrawl.bat",
            "group": "build",
            "presentation": {
                "echo": true,
                "reveal": "always",
                "focus": true,
                "panel": "new"
            },
            "problemMatcher": []
        }
    ]
}
```

### **How to Use**
Run with: `Ctrl+Shift+P` → "Tasks: Run Task" → "Run Engineering Crawler"

**Note:** VS Code settings sync doesn't transfer `.vscode/tasks.json` files. Run `setup_vscode.bat` on each new computer where you want this integration.

## Best Practices

### Project Organization
- **Use descriptive project names**: `your_project` vs `project1`
- **Logical categories**: `specs`, `design_references`, `revit_docs`, `api_docs`
- **Consistent naming**: Use underscores, avoid spaces

### Crawling Strategy
- **Start with single-page crawls** to test site compatibility
- **Use deep crawling for documentation sites** that have good internal linking
- **Check crawl.log files** if results seem incomplete
- **Individual pages** stay organized in `pages/` folder
- **Combined files** include table of contents for large documents

### Site Compatibility
- ✅ **Works great**: Static documentation sites, GitHub Pages, GitBook
- ✅ **Works well**: Most modern websites with standard HTML
- ⚠️ **Limited**: Heavy JavaScript sites, SPAs, sites with anti-bot protection
- ❌ **Avoid**: Notion sites (too complex), sites requiring authentication

## Troubleshooting

### Empty Files
- Increase `delay_before_return_html` in category config
- Try with `headless: false` for JavaScript-heavy sites
- Check site's robots.txt for crawling restrictions

### Unicode/Encoding Errors
- Already handled automatically with UTF-8 encoding
- Files are saved with proper encoding support

### UV Warnings
- Warnings are suppressed in the current version
- They don't affect functionality

### Slow Performance
- Reduce `max_pages` from 50 to smaller number for faster deep crawling
- Increase `delay_before_return_html` for better success rate
- Use single-page crawling for individual documents
- AI cleanup adds minimal time (~1-2 seconds per document)

## Files in This Project

- `engcrawl` - Main Python script (the crawler wrapper)
- `run_engcrawl.bat` - Windows batch file for easy execution
- `setup_engcrawl.bat` - One-time setup script
- `setup_vscode.bat` - VS Code integration setup
- `requirements.txt` - Python dependencies
- `pyproject.toml` - UV project configuration
- `engineering_projects/` - Your crawled content goes here
- `.vscode/tasks.json` - VS Code integration (created by setup_vscode.bat)

## Dependencies

- **Python 3.11+** 
- **UV** - Python package manager
- **crawl4ai** - Core crawling engine
- **pyyaml** - Configuration file support
- **Playwright** - Browser automation (auto-installed)
- **google-generativeai** - Optional, for AI cleanup features

---

## Attribution & License

This project is a specialized fork of [crawl4ai](https://github.com/unclecode/crawl4ai) by [unclecode](https://github.com/unclecode). Engineering Crawler adds project management, interactive workflows, and engineering-specific optimizations while leveraging crawl4ai's excellent web crawling engine.

**Original Project:** https://github.com/unclecode/crawl4ai  
**License:** Same as original crawl4ai project  
**Engineering Enhancements:** Project organization, interactive CLI, AI cleanup, Windows optimization

## Further Learning
For an in-depth exploration, visit my [Flocode Substack newsletter](https://flocode.substack.com/). 📘
Check out [flocode.dev](https://flocode.dev) for more coding resources for engineers 🌊. 💡