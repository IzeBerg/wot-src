package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class DivisionsViewVO extends DAAPIDataClass
   {
      
      private static const FIELD_DIVISIONS:String = "divisions";
       
      
      public var divisions:Vector.<DivisionVO> = null;
      
      public var selectedDivisionIdx:int = -1;
      
      public function DivisionsViewVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == FIELD_DIVISIONS)
         {
            App.utils.asserter.assert(param2 is Array,param1 + Errors.MUST_BE_ARRAY);
            this.divisions = new Vector.<DivisionVO>(0);
            for each(_loc3_ in param2)
            {
               this.divisions.push(new DivisionVO(_loc3_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this.divisions)
         {
            _loc1_.dispose();
         }
         this.divisions.splice(0,this.divisions.length);
         this.divisions = null;
         super.onDispose();
      }
   }
}
