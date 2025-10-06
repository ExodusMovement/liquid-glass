# 🧊 React Native Liquid Glass

Bring your UI into the future with **React Native Liquid Glass** — a sleek, glassmorphic view powered by Apple’s new `UIGlassEffect` in **iOS 18**. Perfectly frosted. Surprisingly easy.

> ⚠️ **iOS 26+ only**
> On Android and on iOS versions below 26, this component returns a `<Pressable />` as a fallback.

---

## ✨ Features

- **System-native glassmorphism** — powered by `UIGlassEffect` for real iOS-level transparency and blur.
- **Plug-and-play simplicity** — drop it in your component tree, no native configuration required.
- **Built with TypeScript** — get full IntelliSense and prop validation out of the box.
- **Safe by design** — auto-fallback ensures compatibility across platforms without conditional logic.
- **Lightweight and fast** — minimal footprint with zero extra dependencies.

---

## 🎬 Demo

<p align="center">
  <img src=".github/images/demo.gif" height="500" />
</p>

---

## 📦 Installation

```sh
yarn add @exodus/liquid-glass
```

---

## 🛠 Requirements

- iOS 26 or higher
- Xcode 26

---

## ⚡ Performance Tip

For optimal performance on iOS, keep either the width or height of your `LiquidGlassView` under **65px**. The native `UIGlassEffect` requires significant processing power, and smaller dimensions help maintain smooth performance.

## 🚀 Usage

```tsx
import LiquidGlassView from '@exodus/liquid-glass';

<LiquidGlassView
  style={{ width: 200, height: 61 }}
  onPress={() => console.log('Tapped the glass!')}
/>
```

---

## 🤝 Contributing

We welcome contributions! Check out our [contributing guide](CONTRIBUTING.md) to get started.

---

## 📄 License

MIT
