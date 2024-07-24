import CommandHistory from './history'

const logo = [
  '           _                         ',
  '  _____   (_)  _____   ____     ____ ',
  ' / ___/  / /  / ___/  / __ \\   / __ \\',
  '/ /__   / /  / /     / / / /  / /_/ /',
  '\\___/  /_/  /_/     /_/ /_/   \\____/ '
]
  .join('<br/>')
  .replace(/\s/g, '&nbsp;')

const output =
  logo +
  [
    '',
    '',
    'Welcome self',
    'Type <span class="red">help</span> to view list available commands'
  ].join('<br/>')

const INIT_MESSAGE: CommandHistory = {
  id: 0,
  val: '',
  output
}

export default INIT_MESSAGE
