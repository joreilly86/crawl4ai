# Engineering Crawler

**A specialized project management wrapper for engineering documentation workflows**

## What This Is

This is **NOT** the original crawl4ai library. This is a purpose-built tool for **engineering professionals** who need to systematically capture, organize, and manage technical documentation from various web sources.

## Key Differences from Original crawl4ai

| Original crawl4ai | Engineering Crawler |
|------------------|---------------------|
| General web crawling library | Engineering-focused documentation tool |
| Python API/CLI for developers | Interactive CLI for end users |
| Single-use crawling | Project-based organization |
| Raw output | Structured with TOC + AI cleanup |
| No project management | Hierarchical project/category system |

## Perfect For

- **Civil Engineers** capturing project specifications and design references
- **Technical Writers** organizing documentation from multiple sources  
- **Project Managers** building comprehensive knowledge bases
- **Engineering Teams** standardizing documentation workflows
- **Anyone** who needs to systematically crawl and organize technical content

## Why Use This Instead of Raw crawl4ai

✅ **Project Organization** - Hierarchical structure instead of scattered files  
✅ **Smart Defaults** - Remembers your projects, categories, and URLs  
✅ **Table of Contents** - Auto-generated navigation for large documents  
✅ **AI Enhancement** - Optional cleanup while preserving technical accuracy  
✅ **Windows Optimized** - Works seamlessly in PowerShell/VS Code  
✅ **UV Integration** - Isolated environments, no global package conflicts  

## Quick Start

```powershell
# One-time setup
PS> .\setup_engcrawl.bat

# Daily usage  
PS> .\run_engcrawl.bat
Project Name?: my_dam_project
Category?: specifications  
URL?: https://example.com/dam-specs
Deep crawl?: y
Combine files?: y
AI cleanup?: y
```

## Use Cases

- **Infrastructure Projects**: Capture specs, regulations, and design standards
- **Software Documentation**: Organize API docs, tutorials, and guides
- **Research Projects**: Systematically collect and organize technical papers
- **Compliance Documentation**: Build comprehensive regulatory knowledge bases

---

**Built on:** [crawl4ai](https://github.com/unclecode/crawl4ai) - Leverages the excellent crawling engine  
**Optimized for:** Engineering documentation workflows and project management  
**License:** Same as original crawl4ai project