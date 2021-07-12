package net.wg.gui.components.controls
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.controls.RadioButton;
   import scaleform.clik.events.InputEvent;
   
   public class RadioButton extends scaleform.clik.controls.RadioButton implements ISoundable
   {
      
      private static const INFO_INV:String = "infoInv";
      
      private static const LINKAGE_INFO_ICON_UI:String = "InfoIconUI";
       
      
      [Inspectable(type="String")]
      public var soundId:String = "";
      
      private var _soundType:String = "radioButton";
      
      private var _infoIcoType:String = "";
      
      private var _infoIco:InfoIcon = null;
      
      private var _infoTooltip:String;
      
      public function RadioButton()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         _label = "";
         toggle = true;
         allowDeselect = false;
         buttonMode = true;
         if(_group == null)
         {
            groupName = null;
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INFO_INV))
         {
            if(StringUtils.isNotEmpty(this._infoIcoType) && StringUtils.isNotEmpty(this._infoTooltip))
            {
               if(!this._infoIco)
               {
                  this.createInfoIco();
               }
               this._infoIco.tooltip = this._infoTooltip;
               this._infoIco.icoType = this._infoIcoType;
               this.repositionInfoIcon();
            }
            else
            {
               this.removeInfoIco();
            }
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.soundMgr.addSoundsHdlrs(this);
      }
      
      override protected function updateText() : void
      {
         if(_label != null && textField != null)
         {
            textField.htmlText = _label;
            invalidate(INFO_INV);
         }
      }
      
      override protected function onDispose() : void
      {
         if(owner != null && owner.hasEventListener(Event.COMPLETE))
         {
            owner.removeEventListener(Event.COMPLETE,this.onCompleteHandler);
         }
         removeEventListener(Event.ADDED,addToAutoGroup,false);
         removeEventListener(Event.REMOVED,addToAutoGroup,false);
         removeEventListener(MouseEvent.ROLL_OVER,handleMouseRollOver,false);
         removeEventListener(MouseEvent.ROLL_OUT,handleMouseRollOut,false);
         removeEventListener(MouseEvent.MOUSE_DOWN,handleMousePress,false);
         removeEventListener(MouseEvent.CLICK,handleMouseRelease,false);
         removeEventListener(MouseEvent.DOUBLE_CLICK,handleMouseRelease,false);
         removeEventListener(InputEvent.INPUT,handleInput,false);
         if(_repeatTimer)
         {
            _repeatTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,beginRepeat,false);
            _repeatTimer.removeEventListener(TimerEvent.TIMER,handleRepeat,false);
         }
         if(App.soundMgr)
         {
            App.soundMgr.removeSoundHdlrs(this);
         }
         if(owner != null)
         {
            this.removeInfoIco();
         }
         super.onDispose();
      }
      
      public function canPlaySound(param1:String) : Boolean
      {
         return this.enabled;
      }
      
      public final function getSoundId() : String
      {
         return this.soundId;
      }
      
      public final function getSoundType() : String
      {
         return this._soundType;
      }
      
      private function repositionInfoIcon() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(this._infoIco)
         {
            _loc1_ = 1 / owner.scaleX;
            _loc2_ = 1 / owner.scaleY;
            this._infoIco.scaleX = _loc1_;
            this._infoIco.scaleY = _loc2_;
            this._infoIco.x = (this.x + textField.x + textField.textWidth + InfoIcon.CHECK_BOX_MARGIN) * _loc1_;
            this._infoIco.y = (this.y + (textField.y + textField.height >> 1)) * _loc2_;
         }
      }
      
      private function createInfoIco() : void
      {
         if(!owner && parent)
         {
            owner = UIComponentEx(parent);
            App.utils.asserter.assertNotNull(owner,"owner" + Errors.CANT_NULL);
         }
         this._infoIco = InfoIcon(App.utils.classFactory.getComponent(LINKAGE_INFO_ICON_UI,InfoIcon));
         owner.addEventListener(Event.COMPLETE,this.onCompleteHandler);
         owner.addChild(this._infoIco);
      }
      
      private function removeInfoIco() : void
      {
         if(this._infoIco)
         {
            this._infoIco.dispose();
            owner.removeChild(this._infoIco);
            this._infoIco = null;
         }
      }
      
      [Inspectable(defaultValue="radioButton",type="String")]
      public function get soundType() : String
      {
         return this._soundType;
      }
      
      public function set soundType(param1:String) : void
      {
         if(param1 && param1 != this._soundType)
         {
            this._soundType = param1;
         }
      }
      
      public function get infoIcoType() : String
      {
         return this._infoIcoType;
      }
      
      public function set infoIcoType(param1:String) : void
      {
         if(param1 == this._infoIcoType)
         {
            return;
         }
         this._infoIcoType = param1;
         invalidate(INFO_INV);
      }
      
      public function get infoTooltip() : String
      {
         return this._infoTooltip;
      }
      
      public function set infoTooltip(param1:String) : void
      {
         if(param1 != this._infoTooltip)
         {
            this._infoTooltip = param1;
            invalidate(INFO_INV);
         }
      }
      
      private function onCompleteHandler(param1:Event) : void
      {
         this.repositionInfoIcon();
      }
   }
}
