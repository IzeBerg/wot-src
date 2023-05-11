package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class OperationsHeaderVO extends DAAPIDataClass
   {
      
      private static const OPERATIONS_FIELD_NAME:String = "operations";
      
      private static const OPERATION_TITLE:String = "operationTitle";
       
      
      public var operations:Vector.<OperationVO> = null;
      
      public var operationTitle:OperationTitleVO = null;
      
      public var backBtnLabel:String = "";
      
      public var backBtnDescrLabel:String = "";
      
      public function OperationsHeaderVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == OPERATIONS_FIELD_NAME)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,OPERATIONS_FIELD_NAME + Errors.CANT_NULL);
            this.clearOperations();
            this.operations = new Vector.<OperationVO>();
            for each(_loc4_ in _loc3_)
            {
               this.operations.push(new OperationVO(_loc4_));
            }
            return false;
         }
         if(param1 == OPERATION_TITLE)
         {
            this.operationTitle = new OperationTitleVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.clearOperations();
         if(this.operationTitle)
         {
            this.operationTitle.dispose();
            this.operationTitle = null;
         }
         super.onDispose();
      }
      
      private function clearOperations() : void
      {
         var _loc1_:IDisposable = null;
         if(this.operations != null)
         {
            for each(_loc1_ in this.operations)
            {
               _loc1_.dispose();
            }
            this.operations.splice(0,this.operations.length);
            this.operations = null;
         }
      }
   }
}
