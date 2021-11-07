package net.wg.gui.lobby.settings.components
{
   import flash.display.Sprite;
   import net.wg.data.constants.KeyProps;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.InfoIcon;
   import net.wg.gui.components.controls.constants.ToolTipShowType;
   import net.wg.gui.lobby.settings.components.evnts.KeyInputEvents;
   import scaleform.clik.controls.ListItemRenderer;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class KeysItemRenderer extends ListItemRenderer
   {
      
      private static const INVALID_DATA:String = "invalid_data";
      
      private static const INVALID_TEXT:String = "invalid_text";
      
      private static const HEADER_STR:String = "header_";
      
      private static const UP_STR:String = "up";
      
      private static const KEY_STR:String = "key";
       
      
      public var keyInput:KeyInput;
      
      public var bg:Sprite;
      
      public var underline:Sprite;
      
      public var infoIcon:InfoIcon;
      
      private var _header:Boolean;
      
      private var _codependentID:String = null;
      
      public function KeysItemRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         invalidate(INVALID_DATA);
      }
      
      override public function toString() : String
      {
         return "[WG KeysItemRenderer " + name + "]";
      }
      
      override protected function onDispose() : void
      {
         data = null;
         if(this.keyInput && this.keyInput.hasEventListener(KeyInputEvents.CHANGE))
         {
            this.keyInput.removeEventListener(KeyInputEvents.CHANGE,this.onKeyChangeHandler);
            this.keyInput.dispose();
         }
         this.keyInput = null;
         this.bg = null;
         this.underline = null;
         this.infoIcon.dispose();
         this.infoIcon = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         constraintsDisabled = true;
         super.configUI();
         mouseChildren = true;
         this.infoIcon.tooltipType = ToolTipShowType.SPECIAL;
         if(this.keyInput)
         {
            this.keyInput.addEventListener(KeyInputEvents.CHANGE,this.onKeyChangeHandler);
            this.keyInput.mouseEnabled = true;
            this.keyInput.mouseChildren = true;
            this.keyInput.buttonMode = true;
         }
      }
      
      override protected function draw() : void
      {
         if(data)
         {
            if(isInvalid(INVALID_DATA))
            {
               this.header = data.header;
               this.keyInput.visible = !data.header;
               this.underline.visible = data.showUnderline;
               this.infoIcon.visible = data.tooltipID != null && data.tooltipID.length > 0;
               this.infoIcon.tooltip = data.tooltipID;
               this._codependentID = data.codependentID;
               this.label = data.label;
               if(!this.header)
               {
                  this.keyInput.keyDefault = data.keyDefault;
                  this.keyInput.setupKey(data.keysRang,data.key);
               }
            }
            if(isInvalid(INVALID_TEXT))
            {
               this.setText();
            }
         }
         super.draw();
      }
      
      override protected function updateText() : void
      {
         if(this._header)
         {
            super.updateText();
         }
      }
      
      override protected function getStatePrefixes() : Vector.<String>
      {
         if(this._header)
         {
            return Vector.<String>([HEADER_STR,Values.EMPTY_STR]);
         }
         return !!_selected ? statesSelected : statesDefault;
      }
      
      public function isSelected() : Boolean
      {
         return this.keyInput.selected;
      }
      
      private function keyCodeWasUsed(param1:Number) : Array
      {
         var _loc7_:KeyProps = null;
         if(param1 == KeyProps.KEY_NONE)
         {
            return [];
         }
         var _loc2_:IDataProvider = KeysScrollingList(owner).dataProvider;
         var _loc3_:int = _loc2_.length;
         var _loc4_:String = null;
         if(this._codependentID)
         {
            _loc7_ = App.utils.commons.keyToString(this.keyInput.keyCode);
            _loc4_ = _loc7_.keyCommand;
         }
         var _loc5_:Array = [];
         var _loc6_:uint = 0;
         while(_loc6_ < _loc3_)
         {
            if(!_loc2_[_loc6_].header && _loc6_ != this.index)
            {
               if(this.keyInput.keyCode == _loc2_[_loc6_].key && (this._codependentID == null || !(this._codependentID && this._codependentID == _loc2_[_loc6_].id && _loc2_[_loc6_].keysRang.indexOf(_loc4_) > -1)))
               {
                  _loc5_.push(_loc2_[_loc6_]);
               }
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      private function setText() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(_label != null && textField != null)
         {
            _loc1_ = Boolean(data.additionalDiscr) ? Number(10) : Number(0);
            _loc2_ = this.bg.height - textField.height;
            _loc3_ = textField.height;
            textField.multiline = true;
            textField.wordWrap = true;
            textField.htmlText = _label;
            textField.height = Math.max(textField.textHeight + 5,_loc3_);
            this.bg.height = textField.height + _loc2_ + _loc1_;
            this.height = this.actualHeight | 0;
            this.keyInput.y = this.height - this.keyInput.height >> 1;
            this.underline.y = this.actualHeight - this.underline.height | 0;
            if(this.infoIcon.visible)
            {
               this.infoIcon.x = textField.x + textField.textWidth + 7;
            }
         }
      }
      
      [Inspectable(defaultValue="true")]
      override public function get enabled() : Boolean
      {
         return super.enabled;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         mouseChildren = true;
      }
      
      [Inspectable(defaultValue="")]
      override public function get label() : String
      {
         return _label;
      }
      
      override public function set label(param1:String) : void
      {
         if(_label == param1)
         {
            return;
         }
         _label = param1;
         invalidate(INVALID_TEXT);
      }
      
      public function get header() : Boolean
      {
         return this._header;
      }
      
      public function set header(param1:Boolean) : void
      {
         if(param1 == this._header)
         {
            return;
         }
         this._header = param1;
         setState(UP_STR);
      }
      
      private function onKeyChangeHandler(param1:KeyInputEvents) : void
      {
         var _loc2_:Array = this.keyCodeWasUsed(param1.keyCode);
         var _loc3_:int = _loc2_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_[_loc4_].key = KeyProps.KEY_NONE;
            _loc4_++;
         }
         if(data && data.hasOwnProperty(KEY_STR))
         {
            data.key = param1.keyCode;
         }
         dispatchEvent(new KeyInputEvents(KeyInputEvents.CHANGE,param1.keyCode));
      }
   }
}
