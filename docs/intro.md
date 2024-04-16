---
sidebar_position: 1
---

# Tutorial Intro ඞ

Let's discover **Docusaurus in less than 5 minutes**.

## Getting Started

Get started by **creating a new site**.

Or **try Docusaurus immediately** with **[docusaurus.new](https://docusaurus.new)**.

### What you'll need

- [Node.js](https://nodejs.org/en/download/) version 16.14 or above:
  - When installing Node.js, you are recommended to check all checkboxes related to dependencies.

## Generate a new site

Generate a new Docusaurus site using the **classic template**.

The classic template will automatically be added to your project after you run the command:

```bash
npm init docusaurus@latest my-website classic
```

You can type this command into Command Prompt, Powershell, Terminal, or any other integrated terminal of your code editor.

The command also installs all necessary dependencies you need to run Docusaurus.

## Start your site

Run the development server:

```bash
cd my-website
npm run start
```

The `cd` command changes the directory you're working with. In order to work with your newly created Docusaurus site, you'll need to navigate the terminal there.

The `npm run start` command builds your website locally and serves it through a development server, ready for you to view at http://localhost:3000/.

Open `docs/intro.md` (this page) and edit some lines: the site **reloads automatically** and displays your changes.

export const Highlight = ({children, color}) => (
<span
style={{
      backgroundColor: color,
      borderRadius: '8px',
      color: '#fff',
      padding: '0.5rem',
      cursor: 'pointer',
    }}
onClick={() => {
alert(`You clicked the color ${color} with label ${children}`);
}}>
{children}
</span>
);

Hello, here's some <Highlight color="red"><em>red text</em></Highlight>

export const Callout = ({children, type}) => (
  <div>
    <div>{type === 'highlight' ? '!' : ''}</div>
    <blockquote>{children}</blockquote>
  </div>
);

<Callout type="highlight">Guild lets you track experiments without changing
your scripts. This saves time and keeps your source independent of an experiment
tracking system.</Callout>

:::info
Guild lets you track experiments without changing
your scripts. This saves time and keeps your source independent of an experiment
tracking system.
:::

<Terminal>guild view</Terminal>

```
This is code/pre.
```

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

<Tabs>
  <TabItem value="apple" label="Apple" default>
    This is an apple 🍎
  </TabItem>
  <TabItem value="orange" label="Orange">
    This is an orange 🍊
  </TabItem>
  <TabItem value="banana" label="Banana">
    This is a banana 🍌
  </TabItem>
</Tabs>
