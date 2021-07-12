package net.wg.gui.components.advanced
{
   import net.wg.infrastructure.interfaces.IViewStackExContent;
   import net.wg.infrastructure.interfaces.IViewStackExPaddingContent;
   import scaleform.clik.utils.Padding;
   
   public class ViewStackExPadding extends ViewStackEx
   {
       
      
      private var _sizePadding:Padding = null;
      
      private var _isApplyPadding:Boolean = true;
      
      public function ViewStackExPadding()
      {
         super();
         this._sizePadding = new Padding();
      }
      
      override protected function configureView(param1:IViewStackExContent) : void
      {
         super.configureView(param1);
         var _loc2_:IViewStackExPaddingContent = IViewStackExPaddingContent(param1);
         this.updateViewPadding(_loc2_);
      }
      
      override protected function onDispose() : void
      {
         this._sizePadding = null;
         super.onDispose();
      }
      
      public function setSizePadding(param1:Padding) : void
      {
         if(this._sizePadding == param1)
         {
            return;
         }
         this._sizePadding = param1;
         if(currentView)
         {
            this.updateViewPadding(IViewStackExPaddingContent(currentView));
         }
      }
      
      private function updateViewPadding(param1:IViewStackExPaddingContent) : void
      {
         param1.setSizePadding(this._sizePadding,this._isApplyPadding);
         if(this._isApplyPadding)
         {
            param1.x = this._sizePadding.left;
            param1.y = this._sizePadding.top;
         }
         param1.validateNow();
      }
      
      public function set isApplyPadding(param1:Boolean) : void
      {
         this._isApplyPadding = param1;
      }
   }
}
