package net.wg.gui.lobby.vehicleCustomization.controls.bottomPanel
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.wg.data.constants.ComponentState;
   import net.wg.data.constants.ImageCacheTypes;
   import net.wg.data.constants.generated.CUSTOMIZATION_ALIASES;
   import net.wg.gui.components.advanced.collapsingBar.ResizableButton;
   import net.wg.gui.components.common.counters.CounterView;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationSoundEvent;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   
   public class CustomizationBottomPanelTabButton extends ResizableButton
   {
      
      private static const ACTIVE_PLUS_ALPHA:Number = 0.8;
      
      private static const INACTIVE_PLUS_ALPHA:Number = 0.4;
      
      private static const HOVER_PLUS_ALPHA:Number = 0.7;
      
      private static const INACTIVE_ICON_ALPHA:Number = 0.5;
      
      private static const HOVER_ICON_ALPHA:int = 1;
      
      private static const COUNTER_PADDING:int = 20;
      
      private static const ICON_SOURCE_INVALID:String = "imageSrcInv";
      
      private static const HOVER_POSTFIX:String = "_hover";
      
      private static const ACTIVE_POSTFIX:String = "_active";
      
      private static const LAST_PREFIX:String = "last_";
      
      private static const COUNTER_Y_OFFSET:int = -7;
      
      private static const OUT:String = "out";
       
      
      public var states:MovieClip = null;
      
      public var icon:Image = null;
      
      public var plus:MovieClip = null;
      
      public var iconActive:Image = null;
      
      public var counter:CounterView = null;
      
      private var _iconSource:String = "";
      
      private var _offsetFromIcon:int = 0;
      
      private var _iconSize:Point;
      
      private var _last:Boolean = false;
      
      public function CustomizationBottomPanelTabButton()
      {
         this._iconSize = new Point();
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         if(this.states != null)
         {
            _labelHash = UIComponent.generateLabelHash(this.states);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.icon.alpha = INACTIVE_ICON_ALPHA;
         this.icon.addEventListener(Event.CHANGE,this.onIconChangeHandler);
         soundEnabled = false;
         this.icon.cacheType = ImageCacheTypes.NOT_USE_CACHE;
         this.counter.y = COUNTER_Y_OFFSET;
         focusable = false;
      }
      
      override protected function calculateOriginWidth() : int
      {
         var _loc1_:int = this.plus.visible || this.hasText ? int(this._offsetFromIcon) : int(0);
         return tabBar.getTextWidth(this) + _loc1_ + this._iconSize.x + (padding << 1);
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.STATE))
         {
            if(StringUtils.isNotEmpty(_newFrame))
            {
               App.utils.asserter.assert(_labelHash.hasOwnProperty(_newFrame),"Not found state " + _newFrame);
               this.states.gotoAndPlay(_newFrame);
               if(_baseDisposed)
               {
                  return;
               }
            }
         }
         super.draw();
         if(isInvalid(ICON_SOURCE_INVALID))
         {
            if(StringUtils.isNotEmpty(this._iconSource))
            {
               this.icon.source = this._iconSource;
               this.iconActive.source = this._iconSource.replace(HOVER_POSTFIX,ACTIVE_POSTFIX);
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.icon.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.icon.dispose();
         this.iconActive.dispose();
         this.counter.dispose();
         this.states = null;
         this.icon = null;
         this.iconActive = null;
         this.plus = null;
         this._iconSource = null;
         this._iconSize = null;
         this.counter = null;
         super.onDispose();
      }
      
      override protected function checkChild(param1:DisplayObject) : Boolean
      {
         return super.checkChild(param1) || param1 != this.icon || param1 != this.iconActive || param1 != this.plus || param1 != this.counter;
      }
      
      override protected function updateScale(param1:Number, param2:Number) : void
      {
         this.icon.scaleX = this.iconActive.scaleX = this.plus.scaleX = this.counter.scaleX = param1;
         this.icon.scaleY = this.iconActive.scaleY = this.plus.scaleY = this.counter.scaleY = param2;
         super.updateScale(param1,param2);
      }
      
      override protected function setState(param1:String) : void
      {
         super.setState(param1);
         if(param1 == ComponentState.DOWN)
         {
            return;
         }
         if(selected)
         {
            this.plus.alpha = ACTIVE_PLUS_ALPHA;
         }
         else
         {
            this.plus.alpha = param1 == ComponentState.OVER ? Number(HOVER_PLUS_ALPHA) : Number(INACTIVE_PLUS_ALPHA);
            this.icon.alpha = param1 == ComponentState.OVER ? Number(HOVER_ICON_ALPHA) : Number(INACTIVE_ICON_ALPHA);
         }
      }
      
      override protected function getStatePrefixes() : Vector.<String>
      {
         if(this._last && !selected)
         {
            return Vector.<String>([LAST_PREFIX]);
         }
         return super.getStatePrefixes();
      }
      
      override protected function updateChildPositions() : void
      {
         var _loc1_:int = hitMc.width >> 1;
         var _loc2_:int = 0;
         var _loc3_:Boolean = textField.text != null && StringUtils.isNotEmpty(textField.text);
         var _loc4_:Boolean = StringUtils.isNotEmpty(this.icon.source);
         if(_loc3_)
         {
            _loc2_ = _loc1_ - (textField.width >> 1);
            if(_loc4_)
            {
               _loc2_ -= this.icon.width + this._offsetFromIcon >> 1;
            }
         }
         else if(_loc4_)
         {
            _loc2_ = _loc1_ - (this.icon.width >> 1);
         }
         if(_loc4_)
         {
            this.icon.x = this.iconActive.x = _loc2_;
            this.icon.y = this.iconActive.y = hitMc.height - this.icon.height >> 1;
            this.plus.x = this.icon.x + this.icon.width + (this._offsetFromIcon - this.plus.width >> 1);
            this.plus.y = this.icon.y + this.icon.height - (this.plus.height >> 1);
            if(_loc3_)
            {
               textField.x = this.icon.x + this.icon.width + this._offsetFromIcon;
               textField.y = hitMc.height - textField.height >> 1;
               this.counter.x = textField.x + textField.width - COUNTER_PADDING | 0;
            }
            else
            {
               this.counter.x = this.icon.x;
            }
         }
         else if(_loc3_)
         {
            if(this.plus.visible)
            {
               textField.x = _loc2_;
               textField.y = hitMc.height - textField.height >> 1;
               this.plus.x = textField.x - this.plus.width;
               this.plus.y = textField.y + textField.height - this.plus.height;
            }
            else
            {
               textField.x = _loc2_;
               textField.y = hitMc.height - textField.height >> 1;
            }
            this.counter.x = textField.x + textField.width - COUNTER_PADDING | 0;
         }
      }
      
      public function setCounter(param1:int) : void
      {
         this.counter.visible = param1 > 0;
         if(this.counter.visible)
         {
            this.counter.setCount(param1.toString());
         }
      }
      
      public function setIconSize(param1:int, param2:int) : void
      {
         if(this._iconSize.x == param1 || this._iconSize.y == param2)
         {
            return;
         }
         this._iconSize.x = param1;
         this._iconSize.y = param2;
      }
      
      public function showPlus(param1:Boolean) : void
      {
         this.plus.visible = param1;
      }
      
      override public function set label(param1:String) : void
      {
         super.label = App.utils.toUpperOrLowerCase(param1,true);
      }
      
      override public function set selected(param1:Boolean) : void
      {
         if(selected != param1)
         {
            this.icon.visible = !param1;
            this.iconActive.visible = param1;
            super.selected = param1;
         }
      }
      
      public function set iconSource(param1:String) : void
      {
         if(this._iconSource != param1)
         {
            this._iconSource = param1;
            invalidate(ICON_SOURCE_INVALID);
         }
      }
      
      public function get hasText() : Boolean
      {
         return StringUtils.isNotEmpty(textField.text);
      }
      
      public function set offsetFromIcon(param1:int) : void
      {
         if(this._offsetFromIcon == param1)
         {
            return;
         }
         this._offsetFromIcon = param1;
         invalidate(LAYOUT_INVALID);
      }
      
      public function get last() : Boolean
      {
         return this._last;
      }
      
      public function set last(param1:Boolean) : void
      {
         this._last = param1;
         this.setState(OUT);
      }
      
      private function onIconChangeHandler(param1:Event) : void
      {
         invalidate(LAYOUT_INVALID);
      }
      
      override protected function onMouseRollOverHandler(param1:MouseEvent) : void
      {
         super.onMouseRollOverHandler(param1);
         dispatchEvent(new CustomizationSoundEvent(CustomizationSoundEvent.PLAY_SOUND,CUSTOMIZATION_ALIASES.SOUND_CUST_HIGHLIGHT));
      }
   }
}
