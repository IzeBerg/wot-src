package net.wg.gui.components.advanced
{
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.infrastructure.interfaces.IViewStackExContent;
   
   public class ViewStackEx extends ViewStack
   {
       
      
      public function ViewStackEx()
      {
         super();
         rescaleContainer = false;
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         var _loc3_:IViewStackExContent = null;
         super.setSize(param1,param2);
         if(currentView)
         {
            _loc3_ = IViewStackExContent(currentView);
            _loc3_.setSize(param1,param2);
            _loc3_.validateNow();
         }
      }
      
      override public function show(param1:String, param2:String) : IViewStackContent
      {
         var _loc3_:IViewStackExContent = currentView as IViewStackExContent;
         if(_loc3_)
         {
            _loc3_.setActive(false);
         }
         var _loc4_:IViewStackExContent = IViewStackExContent(super.show(param1,param2));
         this.configureView(_loc4_);
         _loc4_.setActive(true);
         _loc4_.validateNow();
         return _loc4_;
      }
      
      protected function configureView(param1:IViewStackExContent) : void
      {
         param1.setSize(width,height);
      }
   }
}
