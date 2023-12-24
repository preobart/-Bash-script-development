# bash-project

Это тренировочный репозиторий для практики bash-скриптов.

Задание:

Добавить возможность создавать компоненты со следующей структурой.
```
.UserCard/
├── Button/
│   ├── Button.module.scss
│   └── Button.tsx
├── UserCard.module.scss
├── UserCard.tsx
```

Написать генератор компонентов React по шаблонам.

- `templates.tsx`

```typescript
// name: ""
import React, { ReactElement } from 'React'

import styles from './templates.module.scss'

export const templates = (): ReactElement => {
    return;
}
```

- `templates.module.scss`

```scss
// name: ""
.root{

}
```

## Опции:

- `name`
Задает имя файлам текущего расширения; находится в файлах шаблонов, при пустом значении опции устанавливает имя директории, в которой создаются файлы.
