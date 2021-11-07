package net.wg.gui.bootcamp.messageWindow.views
{
   import flash.display.DisplayObject;
   import net.wg.gui.bootcamp.interfaces.IAnimatedContainerRenderer;
   import net.wg.gui.bootcamp.messageWindow.interfaces.IBottomRenderer;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class MessageViewLines extends MessageViewBase
   {
       
      
      public var animContainerIconSmall:IAnimatedContainerRenderer = null;
      
      private var _bottomView:IBottomRenderer = null;
      
      private var _bottomViewLinkage:String = "";
      
      public function MessageViewLines()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.disposeBottomView();
         this.animContainerIconSmall.dispose();
         this.animContainerIconSmall = null;
         super.onDispose();
      }
      
      override protected function updateContent() : void
      {
         super.updateContent();
         this.animContainerIconSmall.visible = StringUtils.isNotEmpty(messageData.bottomRenderer);
         if(this.animContainerIconSmall.visible)
         {
            this.createBottomView();
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            this.animContainerIconSmall.gotoAndPlay(getMessageStateLabel());
         }
      }
      
      protected function disposeBottomView() : void
      {
         if(this._bottomView != null)
         {
            this._bottomView.dispose();
            this.animContainerIconSmall.removeContent(DisplayObject(this._bottomView));
            this._bottomView = null;
         }
      }
      
      protected function createBottomView() : void
      {
         var _loc1_:IBottomRenderer = null;
         if(this._bottomViewLinkage != messageData.bottomRenderer)
         {
            this.disposeBottomView();
            this._bottomViewLinkage = messageData.bottomRenderer;
            _loc1_ = App.utils.classFactory.getComponent(this._bottomViewLinkage,IBottomRenderer);
            this._bottomView = _loc1_;
            this.animContainerIconSmall.addContent(DisplayObject(this._bottomView));
         }
         if(messageData.bottomData)
         {
            this._bottomView.setData(messageData.bottomData);
         }
      }
   }
}
