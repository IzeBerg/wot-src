package net.wg.gui.lobby.sessionStats.settings
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.components.containers.VerticalGroupLayout;
   import net.wg.gui.lobby.sessionStats.data.SessionStatsSettingsBattleVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class SessionStatsSettingsBattleList extends SessionStatsSettingsBaseBlock
   {
      
      private static const LIST_GAP:int = 8;
      
      private static const STATUS:String = "status";
      
      private static const START_ANIMATION_LABEL:String = "blink";
       
      
      public var warningGlow:MovieClip = null;
      
      public var settingsStatus:TextField = null;
      
      public var list:GroupEx = null;
      
      private var _data:SessionStatsSettingsBattleVO = null;
      
      public function SessionStatsSettingsBattleList()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:VerticalGroupLayout = new VerticalGroupLayout();
         _loc1_.gap = LIST_GAP;
         this.list.layout = _loc1_;
         this.list.itemRendererLinkage = Linkages.SESSION_STATS_CHECKBOX_RENDERER;
         this.list.addEventListener(Event.RESIZE,this.onListResizeHandler);
      }
      
      override protected function onDispose() : void
      {
         this.settingsStatus = null;
         this.warningGlow = null;
         this.list.removeEventListener(Event.RESIZE,this.onListResizeHandler);
         this.list.dispose();
         this.list = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.list.dataProvider = this._data.inputs;
            title.htmlText = this._data.title;
            this.settingsStatus.htmlText = this._data.status;
         }
         if(this._data != null && isInvalid(STATUS))
         {
            this.settingsStatus.htmlText = this._data.status;
         }
      }
      
      public function setData(param1:SessionStatsSettingsBattleVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function setStatus(param1:String) : void
      {
         if(this._data != null)
         {
            this._data.status = param1;
         }
         invalidate(STATUS);
      }
      
      public function playWarningAnimation() : void
      {
         this.warningGlow.gotoAndPlay(START_ANIMATION_LABEL);
      }
      
      private function onListResizeHandler(param1:Event) : void
      {
         setSize(this.list.width,this.list.y + this.list.height + LIST_GAP);
      }
   }
}
