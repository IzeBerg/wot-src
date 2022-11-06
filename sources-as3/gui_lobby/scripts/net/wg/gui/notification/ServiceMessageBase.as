package net.wg.gui.notification
{
   import flash.events.Event;
   import net.wg.gui.notification.vo.NotificationInfoVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IClassFactory;
   import scaleform.clik.constants.InvalidationType;
   
   public class ServiceMessageBase extends UIComponentEx
   {
      
      private static const DEFAULT_CONTENT_LINKAGE:String = "ServiceMessageContent";
      
      private static const CONTENT_CHILD_COMPONENT_NAME:String = "content";
       
      
      public var content:ServiceMessageContent = null;
      
      private var _data:NotificationInfoVO = null;
      
      private var _classFactory:IClassFactory;
      
      private var _currentContentLinkage:String = null;
      
      public function ServiceMessageBase()
      {
         this._classFactory = App.utils.classFactory;
         super();
         this._currentContentLinkage = this.contentLinkage;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         _focusable = tabEnabled = tabChildren = false;
         this.content.addEventListener(Event.RESIZE,this.onContentResizeHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.setupContent();
         }
      }
      
      override protected function onDispose() : void
      {
         this.clearContent();
         if(this._data != null)
         {
            this._data.dispose();
            this._data = null;
         }
         this._classFactory = null;
         super.onDispose();
      }
      
      public function get data() : NotificationInfoVO
      {
         return this._data;
      }
      
      public function set data(param1:NotificationInfoVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      override public function get width() : Number
      {
         return this.content.width;
      }
      
      override public function get height() : Number
      {
         return this.content.height;
      }
      
      override public function validateNow(param1:Event = null) : void
      {
         super.validateNow(param1);
         this.content.validateNow();
      }
      
      protected function get contentLinkage() : String
      {
         if(this._data && this._data.messageVO && this._data.messageVO.linkage)
         {
            return this._data.messageVO.linkage;
         }
         return DEFAULT_CONTENT_LINKAGE;
      }
      
      private function setupContent() : void
      {
         if(this.contentLinkage != this._currentContentLinkage)
         {
            this.clearContent();
            this.content = this._classFactory.getComponent(this.contentLinkage,ServiceMessageContent);
            this.content.addEventListener(Event.RESIZE,this.onContentResizeHandler);
            this.content.name = CONTENT_CHILD_COMPONENT_NAME;
            this._currentContentLinkage = this.contentLinkage;
            this.addChild(this.content);
            invalidateState();
         }
         this.content.data = this._data;
      }
      
      private function clearContent() : void
      {
         this.content.removeEventListener(Event.RESIZE,this.onContentResizeHandler);
         this.removeChild(this.content);
         this.content.dispose();
         this.content = null;
      }
      
      private function onContentResizeHandler(param1:Event) : void
      {
         this.dispatchEvent(new Event(Event.RESIZE));
      }
   }
}
