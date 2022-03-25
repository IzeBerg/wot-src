package net.wg.gui.lobby.missions.components
{
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.QUESTS_ALIASES;
   import net.wg.gui.lobby.missions.event.MissionHeaderEvent;
   import net.wg.utils.IStageSizeDependComponent;
   
   public class RtsMissionPackRenderer extends MissionPackRenderer implements IStageSizeDependComponent
   {
       
      
      private var _rtsBanner:RtsMissionsBanner;
      
      public function RtsMissionPackRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.stageSizeMgr.register(this);
      }
      
      override protected function onDispose() : void
      {
         App.stageSizeMgr.unregister(this);
         if(this._rtsBanner)
         {
            this._rtsBanner.dispose();
            this._rtsBanner = null;
         }
         super.onDispose();
      }
      
      override protected function updateSize() : void
      {
         super.updateSize();
         if(this._rtsBanner && _missionPackVO.blockId == QUESTS_ALIASES.MISSIONS_RTS_BANNER_VIEW_ALIAS)
         {
            height = this._rtsBanner.height;
            this._rtsBanner.x = _width - this._rtsBanner.width >> 1;
         }
      }
      
      override protected function updateBlocks() : void
      {
         if(_missionPackVO.blockId == QUESTS_ALIASES.MISSIONS_RTS_BANNER_VIEW_ALIAS)
         {
            if(_body)
            {
               removeCmp(_body);
               _body = null;
               _currentBodyLinkage = Values.EMPTY_STR;
            }
            if(_header)
            {
               removeCmp(_header);
               _header.removeEventListener(MissionHeaderEvent.COLLAPSE,onHeaderCollapseHandler);
               _header = null;
               _currentHeaderLinkage = Values.EMPTY_STR;
            }
            if(_bg)
            {
               removeChild(_bg);
               _bg = null;
            }
            if(!this._rtsBanner)
            {
               this._rtsBanner = App.utils.classFactory.getComponent(QUESTS_ALIASES.MISSIONS_RTS_BANNER_VIEW_ALIAS,RtsMissionsBanner);
               this._rtsBanner.name = QUESTS_ALIASES.MISSIONS_RTS_BANNER_VIEW_ALIAS;
               addChild(this._rtsBanner);
               this._rtsBanner.validateNow();
            }
         }
         else
         {
            if(this._rtsBanner)
            {
               removeChild(this._rtsBanner);
               this._rtsBanner.dispose();
               this._rtsBanner = null;
            }
            super.updateBlocks();
         }
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         this.updateSize();
      }
   }
}
