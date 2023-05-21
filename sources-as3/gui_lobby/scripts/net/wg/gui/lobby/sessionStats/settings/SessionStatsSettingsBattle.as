package net.wg.gui.lobby.sessionStats.settings
{
   import flash.display.MovieClip;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.ResizableScrollPane;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.lobby.sessionStats.data.SessionStatsSettingsBattleVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class SessionStatsSettingsBattle extends UIComponentEx
   {
      
      private static const SCROLL_STEP_FACTOR:Number = 30;
      
      private static const SCROLL_BAR_PADDING:int = 10;
      
      private static const START_ANIMATION_LABEL:String = "blink";
      
      private static const SCROLLBAR_POSITION_FOR_WARNING:Number = 1.1;
       
      
      public var infoResizableScrollPane:ResizableScrollPane = null;
      
      public var content:SessionStatsSettingsBattleList = null;
      
      public var scrollBar:ScrollBar = null;
      
      public var lipBg:MovieClip = null;
      
      public function SessionStatsSettingsBattle()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.lipBg.mouseChildren = this.lipBg.mouseEnabled = false;
         this.infoResizableScrollPane.scrollBar = this.scrollBar;
         this.infoResizableScrollPane.scrollStepFactor = SCROLL_STEP_FACTOR;
         this.infoResizableScrollPane.target = this.content;
         this.infoResizableScrollPane.scrollPosition = Values.ZERO;
      }
      
      override protected function onDispose() : void
      {
         this.content = null;
         this.lipBg = null;
         this.scrollBar.dispose();
         this.scrollBar = null;
         this.infoResizableScrollPane.dispose();
         this.infoResizableScrollPane = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.scrollBar.x = _width - this.scrollBar.width - SCROLL_BAR_PADDING;
            this.scrollBar.height = _height;
         }
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         super.setSize(param1,param2);
         this.infoResizableScrollPane.setSize(param1,param2);
      }
      
      public function setData(param1:SessionStatsSettingsBattleVO) : void
      {
         this.content.setData(param1);
      }
      
      public function playWarningAnimation() : void
      {
         this.content.playWarningAnimation();
         if(this.scrollBar.position > SCROLLBAR_POSITION_FOR_WARNING)
         {
            this.lipBg.gotoAndPlay(START_ANIMATION_LABEL);
         }
      }
   }
}
