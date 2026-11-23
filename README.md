# dotfiles

Конфиги, разложенные по `~/.config` и `~` симлинками. Репозиторий — источник
правды: правишь файл в репо (или в `~/.config`, это одно и то же) и коммитишь.

## Структура

```
config/                 # зеркало ~/.config
home/                   # зеркало ~/  (.gitconfig и т.п.)
overrides/<host>/…      # версии файлов, которые отличаются на конкретной ОС
manifests/base.list     # что линкуется везде
manifests/darwin.list   # macOS-only
manifests/linux.list    # linux-only (hypr/waybar/sway/omarchy-стек)
bin/dotfiles            # линковщик
```

Строка манифеста — путь относительно репо. Назначение выводится из префикса:

| запись                  | симлинк                    |
| ----------------------- | -------------------------- |
| `config/foo/bar`        | `~/.config/foo/bar`        |
| `home/.gitconfig`       | `~/.gitconfig`             |
| `overrides/linux/…`     | `~/.config/…` (перекрывает) |

Каталог в манифесте = симлинк на весь каталог, файл = симлинк на один файл.
Каталоги, куда приложение пишет свои файлы (fish, pgcli), линкуются
пофайлово, чтобы история/кэш оставались локальными.

## Использование

```sh
./bin/dotfiles status        # что слинковано, а что разъехалось
./bin/dotfiles list          # манифест с итоговыми путями
./bin/dotfiles link          # превью (ничего не меняет)
./bin/dotfiles link -y       # применить
./bin/dotfiles unlink -y     # снять симлинки, ведущие в репо
```

Скрипт идемпотентен. Всё, что уже лежит на месте назначения, не удаляется,
а уносится в `~/.dotfiles-backup/<timestamp>/` с сохранением путей.
Симлинки абсолютные, `--host darwin|linux` — принудительно выбрать набор.

## Новая машина

```sh
git clone git@github.com:ilyaaay/dotfiles.git ~/Projects/dotfiles
~/Projects/dotfiles/bin/dotfiles link      # посмотреть
~/Projects/dotfiles/bin/dotfiles link -y   # применить
```

## Что сюда не входит

- `~/.config/nvim` — отдельный репозиторий `ilyaaay/neovim`.
- `~/.config/opencode` — только `opencode.jsonc`; сессии, `node_modules`,
  `cli.json`, `service.json` не синкаются.
- `~/.config/{cagent,hunk,zed}` — машинное состояние и базы.
- `~/.config/fish/fish_variables` и `~/.config/fish/conf.d/local.fish` —
  машинно-специфичное, в `.gitignore`. Пути/токены/рабочие env кладите в
  `local.fish`; он никогда не линкуется и не коммитится.
- `~/.zshrc`, `~/.aerospace.toml` — пока не управляются.

## Дивергенция macOS / Linux

Одинаковые файлы живут в `config/` и линкуются на обеих машинах.
Если файл обязан отличаться, кладём вариант в `overrides/<host>/config/…`
и добавляем строку в `manifests/<host>.list` — он слинкуется поверх base-версии.

Сейчас так сделан только `alacritty.toml` (Linux-вариант) и
`fish/conf.d/linux.fish` (автостарт sway из TTY).
