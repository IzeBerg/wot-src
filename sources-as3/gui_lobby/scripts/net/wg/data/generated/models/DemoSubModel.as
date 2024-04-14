package net.wg.data.generated.models
{
   import net.wg.gui.data.ViewModel;
   
   public class DemoSubModel extends ViewModel
   {
       
      
      public var description:TextViewModel = null;
      
      public var notes:TextViewModel = null;
      
      public function DemoSubModel()
      {
         super();
         this.description = new TextViewModel();
         registerEmbedViewModel(this.description);
         this.notes = new TextViewModel();
         registerEmbedViewModel(this.notes);
         callbacks = new <Function>[null,null,null,null];
         isManualControlled = true;
      }
      
      public function getCounter() : int
      {
         return getValue(1,ViewModel.INT_TYPE);
      }
      
      public function getHeight() : int
      {
         return getValue(3,ViewModel.INT_TYPE);
      }
      
      public function getIsActive() : Boolean
      {
         return getValue(0,ViewModel.BOOL_TYPE);
      }
      
      public function getWidth() : int
      {
         return getValue(2,ViewModel.INT_TYPE);
      }
      
      public function registerIsActiveCallback(param1:Function) : void
      {
         registerCallbackByIdx(0,param1);
      }
      
      public function registerUpdateCounterCallback(param1:Function) : void
      {
         registerCallbackByIdx(1,param1);
      }
      
      public function registerUpdateHeightCallback(param1:Function) : void
      {
         registerCallbackByIdx(3,param1);
      }
      
      public function registerUpdateWidthCallback(param1:Function) : void
      {
         registerCallbackByIdx(2,param1);
      }
      
      public function setCounter(param1:int) : void
      {
         setValue(1,ViewModel.INT_TYPE,param1);
      }
      
      public function setHeight(param1:int) : void
      {
         setValue(3,ViewModel.INT_TYPE,param1);
      }
      
      public function setIsActive(param1:Boolean) : void
      {
         setValue(0,ViewModel.BOOL_TYPE,param1);
      }
      
      public function setWidth(param1:int) : void
      {
         setValue(2,ViewModel.INT_TYPE,param1);
      }
   }
}
