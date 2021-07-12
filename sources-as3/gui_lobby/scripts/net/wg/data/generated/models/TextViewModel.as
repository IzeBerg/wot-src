package net.wg.data.generated.models
{
   import net.wg.gui.data.ViewModel;
   
   public class TextViewModel extends ViewModel
   {
       
      
      public function TextViewModel()
      {
         super();
         callbacks = new <Function>[null,null];
      }
      
      public function getStringID() : String
      {
         return getValue(0,ViewModel.INT_TYPE);
      }
      
      public function getTextStyleID() : String
      {
         return getValue(1,ViewModel.INT_TYPE);
      }
      
      public function registerUpdaTextStyleCallback(param1:Function) : void
      {
         registerCallbackByIdx(1,param1);
      }
      
      public function registerUpdateStringIDCallback(param1:Function) : void
      {
         registerCallbackByIdx(0,param1);
      }
      
      public function setStringID(param1:int) : void
      {
         return setValue(0,ViewModel.INT_TYPE,param1);
      }
      
      public function setTextStyleID(param1:int) : void
      {
         return setValue(1,ViewModel.INT_TYPE,param1);
      }
   }
}
