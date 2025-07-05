# Engineering Crawler

A simple, interactive project management wrapper for crawl4ai that organizes web crawling into hierarchical engineering projects.

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
Project Name? [salt_river_project]: 
Category? [specs]: 
URL? [https://example.com/docs]: 
Deep crawl (follow links)? [y/N]: y

[DEEP CRAWLING] https://example.com/docs into salt_river_project/specs (max 10 pages, depth 2)
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
├── salt_river_pumped_storage_project/
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
- **What**: Follows links to crawl up to 40 related pages, 2 levels deep
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

**Cost**: ~$0.0001-0.001 per document (Gemini Flash Lite is extremely affordable)

## Configuration Files

### Project Configuration (`.project.yml`)
```yaml
name: salt_river_pumped_storage_project
created: '2025-07-05T10:30:00'
description: 'Engineering project: salt_river_pumped_storage_project'
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
  max_pages: 40
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
            }
        }
    ]
}
```

Run with: `Ctrl+Shift+P` → "Tasks: Run Task" → "Run Engineering Crawler"

## Best Practices

### Project Organization
- **Use descriptive project names**: `salt_river_pumped_storage_project` vs `project1`
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
- Reduce `max_pages` from 40 to smaller number for faster deep crawling
- Increase `delay_before_return_html` for better success rate
- Use single-page crawling for individual documents
- AI cleanup adds minimal time (~1-2 seconds per document)

## Files in This Project

- `engcrawl` - Main Python script (the crawler wrapper)
- `run_engcrawl.bat` - Windows batch file for easy execution
- `setup_engcrawl.bat` - One-time setup script
- `requirements.txt` - Python dependencies
- `pyproject.toml` - UV project configuration
- `engineering_projects/` - Your crawled content goes here
- `.vscode/tasks.json` - VS Code integration

## Dependencies

- **Python 3.11+** 
- **UV** - Python package manager
- **crawl4ai** - Core crawling engine
- **pyyaml** - Configuration file support
- **Playwright** - Browser automation (auto-installed)
- **google-generativeai** - Optional, for AI cleanup features

---

**Created for engineering documentation and knowledge management workflows.**