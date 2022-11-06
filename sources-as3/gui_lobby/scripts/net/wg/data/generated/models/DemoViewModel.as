package net.wg.data.generated.models
{
   import net.wg.gui.data.ViewModel;
   
   public class DemoViewModel extends ViewModel
   {
       
      
      public var subView:DemoSubModel = null;
      
      public function DemoViewModel()
      {
         super();
         isManualControlled = true;
         this.subView = new DemoSubModel();
         registerEmbedViewModel(this.subView);
         callbacks = new <Function>[null,null];
      }
      
      public function getPosX() : int
      {
         return getValue(0,ViewModel.INT_TYPE);
      }
      
      public function getPosY() : int
      {
         return getValue(1,ViewModel.INT_TYPE);
      }
      
      public function setPosX(param1:int) : void
      {
         setValue(0,ViewModel.INT_TYPE,param1);
      }
      
      public function setPosY(param1:int) : void
      {
         setValue(1,ViewModel.INT_TYPE,param1);
      }
      
      public function registerUpdateXCallback(param1:Function) : void
      {
         registerCallbackByIdx(0,param1);
      }
      
      public function registerUpdateYCallback(param1:Function) : void
      {
         registerCallbackByIdx(1,param1);
      }
   }
}
