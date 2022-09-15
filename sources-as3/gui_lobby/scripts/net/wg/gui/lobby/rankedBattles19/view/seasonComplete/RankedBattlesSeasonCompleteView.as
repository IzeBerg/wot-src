package net.wg.gui.lobby.rankedBattles19.view.seasonComplete
{
   import flash.events.Event;
   import net.wg.data.constants.Values;
   import net.wg.gui.lobby.components.data.RibbonAwardsVO;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesSeasonCompleteViewVO;
   import net.wg.gui.lobby.rankedBattles19.events.SeasonCompleteEvent;
   import net.wg.gui.lobby.rankedBattles19.events.SoundEvent;
   import net.wg.infrastructure.base.meta.IRankedBattlesSeasonCompleteViewMeta;
   import net.wg.infrastructure.base.meta.impl.RankedBattlesSeasonCompleteViewMeta;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.motion.Tween;
   import scaleform.clik.ui.InputDetails;
   
   public class RankedBattlesSeasonCompleteView extends RankedBattlesSeasonCompleteViewMeta implements IRankedBattlesSeasonCompleteViewMeta
   {
      
      private static const DEF_WIDTH:uint = 1920;
      
      private static const DEF_HEIGHT:uint = 1200;
      
      private static const FADE_IN_TIME:int = 500;
       
      
      public var container:RankedBattlesSeasonContainer = null;
      
      private var _stageWidth:int = 0;
      
      private var _showTween:Tween = null;
      
      public function RankedBattlesSeasonCompleteView()
      {
         super();
         alpha = Values.ZERO;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         this._stageWidth = param1;
         this.container.updateStage(param1,param2);
         invalidateSize();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.container.addEventListener(SeasonCompleteEvent.NEXT_BTN_CLICK,this.onContainerNextBtnClickHandler);
         this.container.addEventListener(SeasonCompleteEvent.CLOSE_BTN_CLICK,this.onContainerCloseBtnClickHandler);
         this.container.addEventListener(SeasonCompleteEvent.START_INIT_DATA,this.onContainerStartInitDataHandler);
         this.container.addEventListener(SoundEvent.TRIGGER_SOUND,this.onContainerTriggerSoundHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.container.x = this._stageWidth >> 1;
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._showTween)
         {
            this._showTween.paused = true;
            this._showTween.dispose();
            this._showTween = null;
         }
         this.container.removeEventListener(SeasonCompleteEvent.NEXT_BTN_CLICK,this.onContainerNextBtnClickHandler);
         this.container.removeEventListener(SeasonCompleteEvent.CLOSE_BTN_CLICK,this.onContainerCloseBtnClickHandler);
         this.container.removeEventListener(SeasonCompleteEvent.START_INIT_DATA,this.onContainerStartInitDataHandler);
         this.container.removeEventListener(SoundEvent.TRIGGER_SOUND,this.onContainerTriggerSoundHandler);
         this.container.dispose();
         this.container = null;
         super.onDispose();
      }
      
      override protected function setData(param1:RankedBattlesSeasonCompleteViewVO) : void
      {
         this.container.setData(param1);
      }
      
      override protected function setAwardsData(param1:RibbonAwardsVO) : void
      {
         this.container.setAwardsData(param1);
      }
      
      public function as_setPlace(param1:String) : void
      {
         this.container.setPlace(param1);
      }
      
      protected function beforeInitData() : void
      {
         visible = true;
         this._showTween = new Tween(FADE_IN_TIME,this,{"alpha":1},{"paused":false});
      }
      
      protected function tryToCloseView() : void
      {
         showRatingS();
      }
      
      protected function doClose() : void
      {
         closeViewS();
      }
      
      override protected function get autoShowViewProperty() : int
      {
         return SHOW_VIEW_PROP_FORBIDDEN;
      }
      
      override public function get width() : Number
      {
         return DEF_WIDTH;
      }
      
      override public function get height() : Number
      {
         return DEF_HEIGHT;
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(param1.handled)
         {
            return;
         }
         super.handleInput(param1);
         var _loc2_:InputDetails = param1.details;
         var _loc3_:Boolean = _loc2_.value == InputValue.KEY_DOWN;
         if(_loc3_)
         {
            switch(_loc2_.navEquivalent)
            {
               case NavigationCode.ESCAPE:
                  this.doClose();
                  param1.handled = true;
            }
         }
      }
      
      private function onContainerStartInitDataHandler(param1:Event) : void
      {
         this.beforeInitData();
      }
      
      private function onContainerNextBtnClickHandler(param1:Event) : void
      {
         this.tryToCloseView();
      }
      
      private function onContainerCloseBtnClickHandler(param1:Event) : void
      {
         this.doClose();
      }
      
      private function onContainerTriggerSoundHandler(param1:SoundEvent) : void
      {
         onSoundTriggerS(param1.sndName);
      }
   }
}
