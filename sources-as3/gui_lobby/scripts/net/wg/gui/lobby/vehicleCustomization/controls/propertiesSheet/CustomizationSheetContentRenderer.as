package net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CUSTOMIZATION_ALIASES;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationSoundEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IClassFactory;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.gfx.MouseEventEx;
   
   public class CustomizationSheetContentRenderer extends UIComponentEx
   {
      
      private static const IDLE_STATE:String = "idle";
      
      private static const OVER_STATE:String = "over";
      
      private static const DISABLE_STATE:String = "disable";
       
      
      public var background:MovieClip = null;
      
      public var hoverBackground:MovieClip = null;
      
      public var notifyMc:MovieClip = null;
      
      public var backgroundDisable:MovieClip = null;
      
      public var hitMc:Sprite = null;
      
      public var contentContainer:Sprite = null;
      
      public var contentContainerTop:Sprite = null;
      
      private var _content:CustomizationSheetRendererBase = null;
      
      private var _classFactory:IClassFactory;
      
      private var _contentClass:Class = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _disableTooltip:String = "";
      
      private var _notifyTooltip:String = "";
      
      private var _buttonMode:Boolean = false;
      
      private var _notify:Boolean = false;
      
      public function CustomizationSheetContentRenderer()
      {
         this._classFactory = App.utils.classFactory;
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.backgroundDisable.mouseEnabled = this.backgroundDisable.mouseChildren = false;
         this.hoverBackground.mouseEnabled = this.hoverBackground.mouseChildren = false;
         this.background.mouseEnabled = this.background.mouseChildren = false;
         this.notifyMc.mouseEnabled = this.notifyMc.mouseChildren = false;
         this.hitMc.mouseEnabled = this.hitMc.mouseChildren = false;
         this.hitMc.visible = false;
         hitArea = this.hitMc;
         buttonMode = true;
         useHandCursor = true;
      }
      
      public function setContent(param1:Object, param2:Class, param3:String, param4:Boolean) : void
      {
         if(param1)
         {
            this._disableTooltip = param1.disableTooltip;
            this._notifyTooltip = param1.notifyText;
            this._notify = param1.needNotify;
            this._buttonMode = param1.buttonMode;
            this.notifyMc.visible = this._notify;
            if(this._contentClass != param2 || !this._content)
            {
               this._contentClass = param2;
               this.clear();
               this._content = this._classFactory.getComponent(param3,param2);
               this._content.x = 0;
               this._content.y = 0;
               if(this._buttonMode)
               {
                  this.contentContainerTop.addChild(this._content);
               }
               else
               {
                  this.contentContainer.addChild(this._content);
               }
            }
            this._content.isAnimatedTransition = Boolean(param1.animatedTransition) && !param4;
            this._content.setData(param1);
            this._content.enabled = param1.enabled;
            this.enabled = param1.enabled;
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
            visible = true;
         }
         else
         {
            this.clear();
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1 == enabled)
         {
            return;
         }
         super.enabled = param1;
         if(this._content)
         {
            this._content.enabled = param1;
         }
         this.setIdleState();
         buttonMode = enabled;
         useHandCursor = enabled;
         App.utils.scheduler.scheduleOnNextFrame(this.updateMouseEnabled);
      }
      
      private function updateMouseEnabled() : void
      {
         mouseEnabled = true;
      }
      
      private function setIdleState() : void
      {
         if(enabled)
         {
            gotoAndPlay(IDLE_STATE);
         }
         else
         {
            gotoAndPlay(DISABLE_STATE);
         }
      }
      
      public function setLayout(param1:int, param2:int) : void
      {
         if(this._content)
         {
            this._content.setLayout(param1);
         }
         this.background.gotoAndStop(param2);
         this.hoverBackground.gotoAndStop(param2);
         this.backgroundDisable.gotoAndStop(param2);
         this.notifyMc.gotoAndStop(param2);
      }
      
      public function clear() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         if(this._content)
         {
            this.contentContainer.removeChild(this._content);
            this.contentContainerTop.removeChild(this._content);
            this._content.dispose();
            this._content = null;
         }
         visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.clear();
         App.utils.scheduler.cancelTask(this.updateMouseEnabled);
         this.hoverBackground = null;
         this.background = null;
         this.notifyMc = null;
         this.hitMc = null;
         this.contentContainer = null;
         this.contentContainerTop = null;
         this._classFactory = null;
         this._contentClass = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         if(enabled)
         {
            if(this._content)
            {
               gotoAndPlay(OVER_STATE);
               this._content.onOverHandler();
               if(this._notify && StringUtils.isNotEmpty(this._notifyTooltip))
               {
                  this._tooltipMgr.show(this._notifyTooltip);
               }
            }
         }
         else if(StringUtils.isNotEmpty(this._disableTooltip))
         {
            this._tooltipMgr.show(this._disableTooltip);
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         if(enabled)
         {
            if(this._content)
            {
               gotoAndPlay(IDLE_STATE);
               this._content.onOutHandler();
            }
         }
         this._tooltipMgr.hide();
      }
      
      private function onMouseClickHandler(param1:MouseEventEx) : void
      {
         if(param1.buttonIdx != MouseEventEx.LEFT_BUTTON)
         {
            return;
         }
         if(enabled)
         {
            this._content.onClickHandler();
         }
         else
         {
            dispatchEvent(new CustomizationSoundEvent(CustomizationSoundEvent.PLAY_SOUND,CUSTOMIZATION_ALIASES.SOUND_CUST_NEGATIVE));
         }
      }
      
      public function get actionType() : int
      {
         if(this._content)
         {
            return this._content.actionType;
         }
         return Values.DEFAULT_INT;
      }
   }
}
