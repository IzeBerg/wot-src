package net.wg.data.generated.models
{
   import net.wg.gui.data.ViewModel;
   
   public class TestViewModel extends ViewModel
   {
       
      
      public var titleTextModel:TextViewModel;
      
      public var descriptionTextModel:TextViewModel;
      
      public function TestViewModel()
      {
         super();
         this.titleTextModel = new TextViewModel();
         registerEmbedViewModel(this.titleTextModel);
         this.descriptionTextModel = new TextViewModel();
         registerEmbedViewModel(this.descriptionTextModel);
         callbacks = new <Function>[null,null,null];
      }
      
      public function getCounter() : int
      {
         return getValue(0,ViewModel.INT_TYPE);
      }
      
      public function getIsActive() : Boolean
      {
         return getValue(2,ViewModel.BOOL_TYPE);
      }
      
      public function getRate() : Number
      {
         return getValue(1,ViewModel.NUMBER_TYPE);
      }
      
      public function registerIsActiveCallback(param1:Function) : void
      {
         registerCallbackByIdx(2,param1);
      }
      
      public function registerUpdateRateCallback(param1:Function) : void
      {
         registerCallbackByIdx(1,param1);
      }
      
      public function registerUpdateCounterCallback(param1:Function) : void
      {
         registerCallbackByIdx(0,param1);
      }
      
      public function setCounter(param1:int) : void
      {
         setValue(0,ViewModel.INT_TYPE,param1);
      }
      
      public function setIsActive(param1:Boolean) : void
      {
         setValue(2,ViewModel.BOOL_TYPE,param1);
      }
      
      public function setRate(param1:Number) : void
      {
         setValue(1,ViewModel.NUMBER_TYPE,param1);
      }
   }
}
