package net.wg.gui.components.controls
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.ComponentState;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.IContextItem;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.utils.Constraints;
   
   public class ContextMenuItem extends SoundListItemRenderer
   {
      
      private static const CONTEXT_MENU_ITEM_MAIN:String = "main";
      
      private static const TEXT_MARGIN:int = 5;
      
      private static const CHECK_X:int = 15;
      
      private static const CHECK_Y:int = 5;
      
      private static const LINKAGE_CHECKMCUI:String = "CheckMcUI";
      
      private static const LINKAGE_TEXTFIELDSUB:String = "textFieldSub";
      
      private static const PREFIX_SELECTED:String = "selected_";
      
      private static const POSTFIX_DISABLED:String = "_disabled";
      
      private static const BOTTOM_DASH:String = "_";
       
      
      public var id:String = "";
      
      public var subItems:Array;
      
      public var arrowMc:MovieClip;
      
      public var circleMc:MovieClip;
      
      public var textFieldSub:TextField;
      
      public var iconsMc:MovieClip;
      
      public var isNew:Boolean;
      
      private var _type:String = "";
      
      private var _items:Vector.<IContextItem>;
      
      private var _defItemTextWidth:Number = 0;
      
      private var _isOpened:Boolean = false;
      
      private var _checkDynamic:MovieClip = null;
      
      private var _iconType:String = "";
      
      private var _textColor:int = -1;
      
      public const CONTEXT_MENU_ITEM_SUB:String = "sub";
      
      public const CONTEXT_MENU_ITEM_GROUP:String = "group";
      
      public function ContextMenuItem()
      {
         this.subItems = [];
         super();
         soundType = SoundTypes.CONTEXT_MENU;
         useRightButton = false;
         this._defItemTextWidth = width - textField.width;
         visible = this.iconsMc.visible = false;
      }
      
      override public function toString() : String
      {
         return "[WG ContextMenuItem " + name + "]";
      }
      
      override protected function configUI() : void
      {
         if(!constraintsDisabled && this.textFieldSub)
         {
            constraints.addElement(LINKAGE_TEXTFIELDSUB,this.textFieldSub,Constraints.ALL);
         }
         super.configUI();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            switch(this.type)
            {
               case CONTEXT_MENU_ITEM_MAIN:
                  visible = true;
                  this.arrowMc.visible = false;
                  this.circleMc.visible = false;
                  textField.visible = true;
                  this.textFieldSub.visible = false;
                  this.iconsMc.visible = Boolean(this._iconType);
                  break;
               case this.CONTEXT_MENU_ITEM_GROUP:
                  visible = true;
                  this.arrowMc.visible = true;
                  this.circleMc.visible = false;
                  textField.visible = true;
                  this.textFieldSub.visible = false;
                  this.iconsMc.visible = false;
                  break;
               case this.CONTEXT_MENU_ITEM_SUB:
                  this.arrowMc.visible = false;
                  this.iconsMc.visible = false;
                  this.iconsMc.visible = false;
                  if(this._checkDynamic)
                  {
                     this._checkDynamic.visible = !enabled;
                  }
                  else if(!enabled)
                  {
                     this._checkDynamic = App.utils.classFactory.getComponent(LINKAGE_CHECKMCUI,MovieClip);
                     this._checkDynamic.x = CHECK_X;
                     this._checkDynamic.y = CHECK_Y;
                     addChild(this._checkDynamic);
                  }
                  this.circleMc.visible = this._checkDynamic && !enabled ? Boolean(false) : Boolean(true);
                  textField.visible = false;
                  this.textFieldSub.visible = true;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.subItems.splice(0,this.subItems.length);
         this.subItems = null;
         this._checkDynamic = null;
         this.arrowMc = null;
         this.circleMc = null;
         this.textFieldSub = null;
         this.iconsMc = null;
         if(this._items)
         {
            this._items.splice(0,this._items.length);
            this._items = null;
         }
         super.onDispose();
      }
      
      override protected function updateText() : void
      {
         if(_label != null)
         {
            if(textField && textField.visible)
            {
               this.applyText(textField,_label);
            }
            if(this.textFieldSub && this.textFieldSub.visible)
            {
               this.applyText(this.textFieldSub,_label);
            }
         }
      }
      
      override protected function updateAfterStateChange() : void
      {
         if(!initialized)
         {
            return;
         }
         super.updateAfterStateChange();
         if(constraints != null && !constraintsDisabled && this.textFieldSub != null)
         {
            constraints.updateElement(LINKAGE_TEXTFIELDSUB,this.textFieldSub);
         }
      }
      
      override protected function getStatePrefixes() : Vector.<String>
      {
         var _loc1_:String = this.type == this.CONTEXT_MENU_ITEM_SUB ? this.CONTEXT_MENU_ITEM_SUB + BOTTOM_DASH : Values.EMPTY_STR;
         return !!_selected ? Vector.<String>([_loc1_ + PREFIX_SELECTED,Values.EMPTY_STR]) : Vector.<String>([_loc1_]);
      }
      
      override protected function canLog() : Boolean
      {
         return true;
      }
      
      public function invalidWidth() : void
      {
         this.updateText();
         if(this.textFieldSub)
         {
            this.updateItemWidth(this.textFieldSub);
         }
         if(textField)
         {
            this.updateItemWidth(textField);
         }
      }
      
      private function updateItemWidth(param1:TextField) : void
      {
         if(param1.width < param1.textWidth + TEXT_MARGIN)
         {
            width = TEXT_MARGIN + this._defItemTextWidth + param1.textWidth | 0;
         }
      }
      
      private function updateIconType() : void
      {
         if(StringUtils.isNotEmpty(this._iconType))
         {
            this.iconsMc.gotoAndStop(!!super.enabled ? this._iconType : this._iconType + POSTFIX_DISABLED);
            this.iconsMc.visible = true;
         }
         else
         {
            this.iconsMc.visible = false;
         }
      }
      
      private function applyText(param1:TextField, param2:String) : void
      {
         param1.text = param2;
         if(this._textColor >= 0 && enabled)
         {
            param1.textColor = this._textColor;
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         this.updateIconType();
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function set type(param1:String) : void
      {
         if(param1 == this._type)
         {
            return;
         }
         this._type = param1;
         if(enabled)
         {
            setState(ComponentState.UP);
         }
         invalidateState();
      }
      
      public function get items() : Vector.<IContextItem>
      {
         return this._items;
      }
      
      public function set items(param1:Vector.<IContextItem>) : void
      {
         if(param1 == this._items)
         {
            return;
         }
         this._items = param1;
         if(this._items.length > 0)
         {
            this.type = this.CONTEXT_MENU_ITEM_GROUP;
         }
         else
         {
            this.type = CONTEXT_MENU_ITEM_MAIN;
         }
      }
      
      public function get isOpened() : Boolean
      {
         return this._isOpened;
      }
      
      public function set isOpened(param1:Boolean) : void
      {
         if(param1 == this._isOpened)
         {
            return;
         }
         this._isOpened = param1;
         if(this.arrowMc.visible)
         {
            this.arrowMc.gotoAndStop(!!this._isOpened ? ComponentState.DOWN : ComponentState.UP);
         }
      }
      
      public function get iconType() : String
      {
         return this._iconType;
      }
      
      public function set iconType(param1:String) : void
      {
         if(param1 == this._iconType)
         {
            return;
         }
         this._iconType = param1;
         this.updateIconType();
      }
      
      public function get textColor() : int
      {
         return this._textColor;
      }
      
      public function set textColor(param1:int) : void
      {
         if(param1 == this._textColor)
         {
            return;
         }
         this._textColor = param1;
         this.updateText();
      }
      
      override protected function callLogEvent(param1:Event) : void
      {
         App.eventLogManager.logUIEventContextMenuItem(param1,_index);
      }
   }
}
