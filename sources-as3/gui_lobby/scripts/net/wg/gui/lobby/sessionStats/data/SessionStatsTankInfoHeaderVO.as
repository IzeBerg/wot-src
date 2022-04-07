package net.wg.gui.lobby.sessionStats.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SessionStatsTankInfoHeaderVO extends DAAPIDataClass
   {
      
      private static const TANK_PARAMS:String = "tankParams";
       
      
      public var tankName:String = "";
      
      public var flagImage:String = "";
      
      public var tankImage:String = "";
      
      public var smallSize:Boolean = false;
      
      public var tankType:String = "";
      
      public var tankTier:String = "";
      
      public var tankNameSmall:String = "";
      
      public var isElite:Boolean = false;
      
      public var isFavorite:Boolean = false;
      
      public var favoriteText:String = "";
      
      public var tankParams:Vector.<SessionStatsTankInfoParamVO> = null;
      
      public function SessionStatsTankInfoHeaderVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == TANK_PARAMS && param2)
         {
            this.tankParams = new Vector.<SessionStatsTankInfoParamVO>();
            for each(_loc3_ in param2)
            {
               this.tankParams.push(new SessionStatsTankInfoParamVO(_loc3_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.tankParams)
         {
            for each(_loc1_ in this.tankParams)
            {
               _loc1_.dispose();
               _loc1_ = null;
            }
            this.tankParams = null;
         }
         super.onDispose();
      }
   }
}
