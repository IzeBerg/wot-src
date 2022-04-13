package net.wg.gui.lobby.battlequeue
{
   import fl.motion.easing.Cubic;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.techtree.helpers.TweenWrapper;
   import net.wg.infrastructure.base.meta.IRTSBattleQueueMeta;
   import net.wg.infrastructure.base.meta.impl.RTSBattleQueueMeta;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.motion.Tween;
   
   public class RTSBattleQueue extends RTSBattleQueueMeta implements IRTSBattleQueueMeta
   {
      
      private static const MIN_POS_Y:int = 80;
      
      private static const CONTENT_MIN_POS_Y:int = 60;
      
      private static const CONTENT_OFFSET_Y:int = 70;
      
      private static const INV_TYPE_INFO:String = "InvTypeInfo";
      
      private static const TEAM_NAME_OFFSET:int = 4;
      
      private static const TNK_ICON_OFFSET:int = 4;
      
      private static const TNK_NAME_OFFSET:int = 14;
      
      private static const TWEEN_DURATION:int = 600;
      
      private static const WIDGET_TWEEN_Y_OFFSET:int = 109;
      
      private static const WIDGET_TWEEN_Y_DEFAULT_OFFSET:int = -20;
      
      private static const CONTAINER_WIDTH:int = 1024;
       
      
      public var tankIcon:UILoaderAlt;
      
      public var teamName:TextField;
      
      public var changeWidget:RTSChangeVehicleWidget;
      
      public var changeWidgetMask:Sprite;
      
      public var content:RTSBattleQueueContent;
      
      public var background:Sprite;
      
      private var _changeWidgetTweenWrapper:TweenWrapper = null;
      
      private var _changeWidgetTween:Tween = null;
      
      private var _showedDefaultWidgetY:int = 0;
      
      private var _widgetVisible:Boolean = false;
      
      private var _maskHeight:int = 0;
      
      private var _stageWidth:int = 0;
      
      private var _stageHeight:int = 0;
      
      public function RTSBattleQueue()
      {
         super();
         battleIcon = this.content.battleIcon;
         battleIconBg = this.content.battleIconBg;
         playersLabel = this.content.playersLabel;
         modeTitle = this.content.modeTitle;
         listByType = this.content.listByType;
         this.tankIcon = this.content.footer.tankIcon;
         this.teamName = this.content.footer.teamName;
         exitButton = this.content.footer.exitButton;
         startButton = this.content.footer.startButton;
         timerLabel = this.content.footer.timerLabel;
         timerText = this.content.footer.timerText;
         tankLabel = this.content.footer.tankLabel;
         tankName = this.content.footer.tankName;
         gameplayTip = this.content.footer.gameplayTip;
         additional = this.content.footer.additional;
         tankLabel.autoSize = TextFieldAutoSize.RIGHT;
         tankName.autoSize = TextFieldAutoSize.RIGHT;
         this.teamName.autoSize = TextFieldAutoSize.RIGHT;
         timerLabel.autoSize = TextFieldAutoSize.RIGHT;
         this._changeWidgetTweenWrapper = new TweenWrapper(this.changeWidget);
         this.changeWidget.mask = this.changeWidgetMask;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         this._stageWidth = param1;
         this._stageHeight = param2;
         this.x = param1 - CONTAINER_WIDTH >> 1;
         var _loc3_:DisplayObject = getChildAt(0);
         this.y = Math.min((param2 - _loc3_.height >> 1) - parent.y,MIN_POS_Y);
         this._showedDefaultWidgetY = param2 - this.changeWidget.height - this.y - WIDGET_TWEEN_Y_DEFAULT_OFFSET;
         if(this._widgetVisible && (this._changeWidgetTween == null || this._changeWidgetTween.paused))
         {
            this._changeWidgetTweenWrapper.y = this._showedDefaultWidgetY;
         }
         else if(!this._widgetVisible)
         {
            this._changeWidgetTweenWrapper.y = this._showedDefaultWidgetY + WIDGET_TWEEN_Y_OFFSET + WIDGET_TWEEN_Y_DEFAULT_OFFSET;
         }
         this._maskHeight = param2 - this.changeWidgetMask.y - this.y;
         this.changeWidgetMask.height = this._maskHeight;
         this.content.updateStage(this._stageWidth,this._stageHeight);
         this.layoutContent();
         if(this.background.visible)
         {
            this.background.x = -this.x;
            this.background.y = -this.y;
            this.background.width = this._stageWidth;
            this.background.height = this._stageHeight;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.changeWidget.addEventListener(ButtonEvent.CLICK,this.onChangeWidgetClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this.teamName = null;
         this.tankIcon.dispose();
         this.tankIcon = null;
         this.cleanTweens();
         this._changeWidgetTweenWrapper.dispose();
         this._changeWidgetTweenWrapper = null;
         this.changeWidget.removeEventListener(ButtonEvent.CLICK,this.onChangeWidgetClickHandler);
         this.changeWidget.mask = null;
         this.changeWidget = null;
         this.changeWidgetMask = null;
         this.background = null;
         this.content.dispose();
         this.content = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:RTSBattleQueueTypeInfoVO = null;
         var _loc2_:Boolean = false;
         super.draw();
         if(typeInfo && isInvalid(INV_TYPE_INFO))
         {
            if(_baseDisposed)
            {
               return;
            }
            if(typeInfo is RTSBattleQueueTypeInfoVO)
            {
               _loc1_ = typeInfo as RTSBattleQueueTypeInfoVO;
               modeTitle.text = _loc1_.title;
               gameplayTip.text = _loc1_.description;
               additional.htmlText = _loc1_.additional;
               tankLabel.htmlText = _loc1_.tankLabel;
               this.teamName.text = _loc1_.teamName;
               this.teamName.x = tankLabel.x + tankLabel.width + TEAM_NAME_OFFSET >> 0;
               _loc2_ = typeInfo.tankIcon != Values.EMPTY_STR;
               if(_loc2_)
               {
                  this.tankIcon.source = typeInfo.tankIcon;
                  this.tankIcon.x = this.teamName.x + this.teamName.width + TNK_ICON_OFFSET >> 0;
                  tankName.text = typeInfo.tankName;
                  tankName.x = this.tankIcon.x + TNK_NAME_OFFSET;
               }
               tankName.visible = this.tankIcon.visible = _loc2_;
               this.background.visible = _loc1_.isRTSBootcamp;
            }
         }
      }
      
      override protected function setRTSDP(param1:DataProvider) : void
      {
         this.content.setDP(param1);
         this.layoutContent();
      }
      
      override protected function getBattleQueueTypeInfoVOForData(param1:Object) : BattleQueueTypeInfoVO
      {
         return new RTSBattleQueueTypeInfoVO(param1);
      }
      
      override protected function showSwitchVehicle(param1:RTSChangeVehicleWidgetVO) : void
      {
         this.changeWidget.setData(param1);
         if(!this._widgetVisible)
         {
            this._widgetVisible = true;
            this._changeWidgetTweenWrapper.y = this._showedDefaultWidgetY + WIDGET_TWEEN_Y_OFFSET;
            this.changeWidgetMask.height = this._maskHeight;
            this.cleanTweens();
            this._changeWidgetTween = new Tween(TWEEN_DURATION,this._changeWidgetTweenWrapper,{
               "y":this._showedDefaultWidgetY,
               "alpha":1
            },{
               "ease":Cubic.easeOut,
               "paused":false,
               "onComplete":this.onChangeShowWidgetTweenComplete
            });
         }
      }
      
      public function as_hideSwitchVehicle() : void
      {
         this.cleanTweens();
         this._changeWidgetTween = new Tween(TWEEN_DURATION,this._changeWidgetTweenWrapper,{
            "y":this._showedDefaultWidgetY + WIDGET_TWEEN_Y_OFFSET,
            "alpha":0
         },{
            "ease":Cubic.easeInOut,
            "paused":false,
            "onComplete":this.onChangeHideWidgetTweenComplete
         });
      }
      
      private function onChangeShowWidgetTweenComplete() : void
      {
         this.cleanTweens();
      }
      
      private function onChangeHideWidgetTweenComplete() : void
      {
         this.cleanTweens();
      }
      
      private function cleanTweens() : void
      {
         if(this._changeWidgetTween != null)
         {
            this._changeWidgetTween.paused = true;
            this._changeWidgetTween.dispose();
            this._changeWidgetTween = null;
         }
      }
      
      private function layoutContent() : void
      {
         var _loc1_:int = (this._stageHeight - this.y - this.content.height >> 1) - CONTENT_OFFSET_Y;
         this.content.y = _loc1_ < CONTENT_MIN_POS_Y ? Number(CONTENT_MIN_POS_Y) : Number(_loc1_);
      }
      
      private function onChangeWidgetClickHandler(param1:ButtonEvent) : void
      {
         onSwitchVehicleClickS();
      }
   }
}
