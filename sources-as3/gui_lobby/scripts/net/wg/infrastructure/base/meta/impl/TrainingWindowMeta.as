package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.VO.TrainingWindowVO;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class TrainingWindowMeta extends AbstractWindowView
   {
       
      
      public var updateTrainingRoom:Function;
      
      private var _trainingWindowVO:TrainingWindowVO;
      
      private var _dataProvider:DataProvider;
      
      public function TrainingWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._trainingWindowVO)
         {
            this._trainingWindowVO.dispose();
            this._trainingWindowVO = null;
         }
         if(this._dataProvider)
         {
            this._dataProvider.cleanUp();
            this._dataProvider = null;
         }
         super.onDispose();
      }
      
      public function updateTrainingRoomS(param1:Number, param2:Number, param3:int, param4:String) : void
      {
         App.utils.asserter.assertNotNull(this.updateTrainingRoom,"updateTrainingRoom" + Errors.CANT_NULL);
         this.updateTrainingRoom(param1,param2,param3,param4);
      }
      
      public final function as_setData(param1:Object, param2:Array) : void
      {
         var _loc3_:TrainingWindowVO = this._trainingWindowVO;
         this._trainingWindowVO = new TrainingWindowVO(param1);
         var _loc4_:DataProvider = this._dataProvider;
         this._dataProvider = new DataProvider(param2);
         this.setData(this._trainingWindowVO,this._dataProvider);
         if(_loc3_)
         {
            _loc3_.dispose();
         }
         if(_loc4_)
         {
            _loc4_.cleanUp();
         }
      }
      
      protected function setData(param1:TrainingWindowVO, param2:DataProvider) : void
      {
         var _loc3_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
   }
}
