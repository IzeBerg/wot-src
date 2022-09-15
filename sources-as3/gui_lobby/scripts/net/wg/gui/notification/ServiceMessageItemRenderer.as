package net.wg.gui.notification
{
   import net.wg.gui.components.interfaces.IReusableListItemRenderer;
   import net.wg.gui.notification.events.NotificationListEvent;
   import net.wg.gui.notification.vo.NotificationInfoVO;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   
   public class ServiceMessageItemRenderer extends ServiceMessageBase implements IReusableListItemRenderer
   {
      
      private static const SINGLE_RENDERER_LABEL:String = "single";
      
      private static const FIRST_RENDERER_LABEL:String = "first";
      
      private static const DEFAULT_RENDERER_LABEL:String = "normal";
      
      private static const LAST_RENDERER_LABEL:String = "last";
      
      private static const CONTENT_LINKAGE_POSTFIX:String = "IR_UI";
       
      
      private var _index:uint = 0;
      
      private var _selectable:Boolean = false;
      
      private var _selected:Boolean = false;
      
      private var _owner:UIComponent = null;
      
      private var _backgroundLabel:String = null;
      
      public function ServiceMessageItemRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.mouseEnabled = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            if(this._backgroundLabel && content.background)
            {
               content.background.gotoAndStop(this._backgroundLabel);
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this._owner = null;
         super.onDispose();
      }
      
      public function cleanUp() : void
      {
      }
      
      public function getData() : Object
      {
         return this.data;
      }
      
      public function setData(param1:Object) : void
      {
         this.data = param1 as NotificationInfoVO;
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
            this._owner.removeEventListener(NotificationListEvent.UPDATE_INDEXES,this.onOwnerUpdateIndexesHandler);
         }
         this._owner = param1;
         if(this._owner)
         {
            this._owner.addEventListener(NotificationListEvent.UPDATE_INDEXES,this.onOwnerUpdateIndexesHandler);
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
      
      override protected function get contentLinkage() : String
      {
         return super.contentLinkage + CONTENT_LINKAGE_POSTFIX;
      }
      
      private function onOwnerUpdateIndexesHandler(param1:NotificationListEvent) : void
      {
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
            invalidateState();
         }
      }
   }
}
