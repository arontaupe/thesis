import requests
import json

# Doc site: https://plugins-doc.logseq.com/ .
# This list is auto-generated from https://github.com/logseq/plugins/tree/master/docs .
apis = [
    'logseq.settings',
    'logseq.updateSettings',
    'logseq.once',
    'logseq.toggleMainUI',
    'logseq.listeners',
    'logseq.ready',
    'logseq.connected',
    'logseq.removeListener',
    'logseq.showMainUI',
    'logseq.resolveResourceFullUrl',
    'logseq.provideStyle',
    'logseq.caller',
    'logseq.addListener',
    'logseq.hideSettingsUI',
    'logseq.provideUI',
    'logseq.setMainUIInlineStyle',
    'logseq.emit',
    'logseq.showSettingsUI',
    'logseq.listenerCount',
    'logseq.removeAllListeners',
    'logseq.onSettingsChanged',
    'logseq.provideTheme',
    'logseq.Experiments',
    'logseq.eventNames',
    'logseq.FileStorage',
    'logseq.provideModel',
    'logseq.baseInfo',
    'logseq.setMainUIAttrs',
    'logseq.useSettingsSchema',
    'logseq.hideMainUI',
    'logseq.isMainUIVisible',
    'logseq.beforeunload',
    'logseq.UI.showMsg',
    'logseq.UI.closeMsg',
    'logseq.App.registerPageMenuItem',
    'logseq.App.getUserInfo',
    'logseq.App.setRightSidebarVisible',
    'logseq.App.showMsg',
    'logseq.App.quit',
    'logseq.App.registerUIItem',
    'logseq.App.setFullScreen',
    'logseq.App.onMacroRendererSlotted',
    'logseq.App.getInfo',
    'logseq.App.onPageHeadActionsSlotted',
    'logseq.App.onCurrentGraphChanged',
    'logseq.App.registerCommandShortcut',
    'logseq.App.getStateFromStore',
    'logseq.App.onSidebarVisibleChanged',
    'logseq.App.registerCommand',
    'logseq.App.setLeftSidebarVisible',
    'logseq.App.replaceState',
    'logseq.App.setZoomFactor',
    'logseq.App.execGitCommand',
    'logseq.App.invokeExternalCommand',
    'logseq.App.queryElementById',
    'logseq.App.onThemeModeChanged',
    'logseq.App.openExternalLink',
    'logseq.App.pushState',
    'logseq.App.getCurrentGraph',
    'logseq.App.onRouteChanged',
    'logseq.App.queryElementRect',
    'logseq.App.registerCommandPalette',
    'logseq.App.relaunch',
    'logseq.App.getUserConfigs',
    'logseq.App.onBlockRendererSlotted',
    'logseq.DB.datascriptQuery',
    'logseq.DB.onChanged',
    'logseq.DB.q',
    'logseq.DB.onBlockChanged',
    'logseq.Assets.listFilesOfCurrentGraph',
    'logseq.Editor.insertBatchBlock',
    'logseq.Editor.getAllPages',
    'logseq.Editor.createPage',
    'logseq.Editor.getBlockProperty',
    'logseq.Editor.getBlockProperties',
    'logseq.Editor.insertAtEditingCursor',
    'logseq.Editor.getCurrentPage',
    'logseq.Editor.appendBlockInPage',
    'logseq.Editor.getSelectedBlocks',
    'logseq.Editor.insertBlock',
    'logseq.Editor.getPagesTreeFromNamespace',
    'logseq.Editor.onInputSelectionEnd',
    'logseq.Editor.scrollToBlockInPage',
    'logseq.Editor.moveBlock',
    'logseq.Editor.getPreviousSiblingBlock',
    'logseq.Editor.exitEditingMode',
    'logseq.Editor.getPagesFromNamespace',
    'logseq.Editor.getNextSiblingBlock',
    'logseq.Editor.getPage',
    'logseq.Editor.renamePage',
    'logseq.Editor.prependBlockInPage',
    'logseq.Editor.deletePage',
    'logseq.Editor.editBlock',
    'logseq.Editor.checkEditing',
    'logseq.Editor.getCurrentPageBlocksTree',
    'logseq.Editor.getCurrentBlock',
    'logseq.Editor.upsertBlockProperty',
    'logseq.Editor.registerSlashCommand',
    'logseq.Editor.getPageBlocksTree',
    'logseq.Editor.getPageLinkedReferences',
    'logseq.Editor.updateBlock',
    'logseq.Editor.registerBlockContextMenuItem',
    'logseq.Editor.removeBlock',
    'logseq.Editor.restoreEditingCursor',
    'logseq.Editor.removeBlockProperty',
    'logseq.Editor.getBlock',
    'logseq.Editor.openInRightSidebar',
    'logseq.Editor.setBlockCollapsed',
    'logseq.Editor.getEditingBlockContent',
    'logseq.Editor.getEditingCursorPosition',
    'logseq.Git.saveIgnoreFile',
    'logseq.Git.loadIgnoreFile',
    'logseq.Git.execCommand']


def raw_api_call(host, port, token, method, args):
    resp = requests.post(f'http://{host}:{port}/api', json={
        'method': method,
        'args': args
    }, headers={
        'Authorization': 'Bearer ' + token
    })
    try:
        return resp.json()
    except json.JSONDecodeError:
        return resp.text


def _define_api(host, port, token, cls, method):
    [_, *hier, name] = method.split('.')

    @staticmethod
    def _wrap(*args):
        return raw_api_call(host, port, token, method, args)

    if hier:
        for ns in hier:
            if not hasattr(cls, ns):
                setattr(cls, ns, type(ns, (object,), {}))
            cls = getattr(cls, ns)
    setattr(cls, name, _wrap)


def _create_class(host, port, token):
    class Logseq: pass

    for api in apis:
        _define_api(host, port, token, Logseq, api)
    return Logseq


def Logseq(host, port, token):
    return _create_class(host, port, token)()

def add_to_last_block_as_child(page, block_content, logseq):
    # Step 1: Get all blocks from the page
    blocks = logseq.Editor.getPageBlocksTree(page)
    assert blocks, "No blocks found in the page"

    # Step 2: Find the last block
    if blocks and isinstance(blocks, list) and len(blocks) > 0:
        last_block = blocks[-1]  # Get the last block in the list
        parent_block_uuid = last_block.get("uuid")
        #print(f"Last block UUID: {parent_block_uuid}")

        # Step 3: Insert a new block as a child of the last block
        logseq.Editor.insertBlock(parent_block_uuid, block_content, {"children": "true"})


# Usage:
if __name__ == '__main__':
    logseq = Logseq('127.0.0.1', '12315', 'vetinari')
    logseq.Editor.deletePage('APITest')
    logseq.Editor.createPage('APITest')
    logseq.Editor.checkEditing()
    logseq.Editor.appendBlockInPage('APITest', 'Parent block')
    add_to_last_block_as_child('APITest', 'Child block', logseq)

    logseq.App.showMsg('Testing API')

