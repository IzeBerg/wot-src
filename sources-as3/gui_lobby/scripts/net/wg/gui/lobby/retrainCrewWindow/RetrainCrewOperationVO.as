package net.wg.gui.lobby.retrainCrewWindow
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.tankman.vo.RetrainButtonVO;
   
   public class RetrainCrewOperationVO extends DAAPIDataClass
   {
      
      private static const RETRAIN_BUTTONS_FIELD_NAME:String = "retrainButtons";
       
      
      public var credits:int;
      
      public var gold:int;
      
      public var tankmanCost:Array;
      
      public var retrainButtons:Vector.<RetrainButtonVO>;
      
      public function RetrainCrewOperationVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         switch(param1)
         {
            case RETRAIN_BUTTONS_FIELD_NAME:
               this.retrainButtons = new Vector.<RetrainButtonVO>(0);
               for each(_loc3_ in param2)
               {
                  this.retrainButtons.push(new RetrainButtonVO(_loc3_));
               }
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:RetrainButtonVO = null;
         for each(_loc1_ in this.retrainButtons)
         {
            _loc1_.dispose();
         }
         this.retrainButtons.length = 0;
         this.retrainButtons = null;
         super.onDispose();
      }
   }
}
