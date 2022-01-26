package net.wg.gui.notification
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import net.wg.gui.components.interfaces.IReusableListItemRenderer;
   import net.wg.gui.notification.events.NotificationListEvent;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   
   public class ServiceMessageItemRenderer extends ServiceMessage implements IReusableListItemRenderer
   {
      
      private static const SINGLE_RENDERER_LABEL:String = "single";
      
      private static const FIRST_RENDERER_LABEL:String = "first";
      
      private static const DEFAULT_RENDERER_LABEL:String = "normal";
      
      private static const LAST_RENDERER_LABEL:String = "last";
      
      private static const LUNAR_NY_ICON_SIZE:uint = 128;
      
      private static const LUNAR_NY_ICON_X:uint = 82;
      
      private static const LUNAR_NY_ICON_Y:uint = 15;
       
      
      private var _index:uint;
      
      private var _selectable:Boolean;
      
      private var _selected:Boolean;
      
      private var _owner:UIComponent;
      
      private var _backgroundLabel:String = "";
      
      public function ServiceMessageItemRenderer()
      {
         super();
      }
      
      override public function toString() : String
      {
         return "[Service message ListItemRenderer " + this.index + ", " + name + "]";
      }
      
      override protected function configUI() : void
      {
         var _loc3_:DisplayObject = null;
         super.configUI();
         focusTarget = this._owner;
         _focusable = tabEnabled = tabChildren = false;
         var _loc1_:int = numChildren;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = getChildAt(_loc2_);
            if(_loc3_ is InteractiveObject && _loc3_ != textField && _loc3_ != buttonsGroup)
            {
               InteractiveObject(_loc3_).mouseEnabled = false;
            }
            _loc2_++;
         }
         _lunarNYSettings.iconW = LUNAR_NY_ICON_SIZE;
         _lunarNYSettings.iconH = LUNAR_NY_ICON_SIZE;
         _lunarNYSettings.iconX = LUNAR_NY_ICON_X;
         _lunarNYSettings.iconY = LUNAR_NY_ICON_Y;
      }
      
      override protected function onDispose() : void
      {
         this.owner = null;
         super.onDispose();
      }
      
      public function cleanUp() : void
      {
         icon.unload();
         icon.setSourceSize(icon.originalWidth,icon.originalHeight);
         bgIcon.unload();
         bgIcon.setSourceSize(bgIcon.originalWidth,bgIcon.originalHeight);
      }
      
      public function getData() : Object
      {
         return this.data;
      }
      
      public function setData(param1:Object) : void
      {
         this.data = param1;
      }
      
      public function setListData(param1:ListData) : void
      {
         this.index = param1.index;
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = param1;
      }
      
      public function get selectable() : Boolean
      {
         return this._selectable;
      }
      
      public function set selectable(param1:Boolean) : void
      {
         this._selectable = param1;
      }
      
      public function get owner() : UIComponent
      {
         return this._owner;
      }
      
      public function set owner(param1:UIComponent) : void
      {
         if(this._owner)
         {
            this._owner.removeEventListener(NotificationListEvent.UPDATE_INDEXES,this.onOwnerUpdateIndexesHandler,false);
         }
         this._owner = param1;
         if(this._owner)
         {
            this._owner.addEventListener(NotificationListEvent.UPDATE_INDEXES,this.onOwnerUpdateIndexesHandler,false,0,true);
         }
         this.focusTarget = this._owner;
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         this._selected = param1;
      }
      
      private function onOwnerUpdateIndexesHandler(param1:NotificationListEvent) : void
      {
         if(!background)
         {
            return;
         }
         var _loc2_:int = param1.length;
         var _loc3_:String = DEFAULT_RENDERER_LABEL;
         if(this.index == 0)
         {
            _loc3_ = _loc2_ > 0 ? FIRST_RENDERER_LABEL : SINGLE_RENDERER_LABEL;
         }
         else if(this.index + 1 == _loc2_)
         {
            _loc3_ = LAST_RENDERER_LABEL;
         }
         if(_loc3_ != this._backgroundLabel)
         {
            this._backgroundLabel = _loc3_;
            background.gotoAndStop(this._backgroundLabel);
         }
      }
   }
}
