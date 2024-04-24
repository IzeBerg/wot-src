package net.wg.gui.lobby.missions.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class MissionAccountRequirementRendererVO extends DAAPIDataClass
   {
      
      private static const TOKENS:String = "tokens";
       
      
      public var icon:String = "";
      
      public var text:String = "";
      
      public var isNeedShowIcon:Boolean = true;
      
      private var _tokens:DataProvider;
      
      public function MissionAccountRequirementRendererVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this._tokens != null)
         {
            for each(_loc1_ in this._tokens)
            {
               _loc1_.dispose();
            }
            this._tokens.cleanUp();
            this._tokens = null;
         }
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == TOKENS)
         {
            App.utils.asserter.assertNotNull(param2,TOKENS + Errors.CANT_NULL);
            this._tokens = new DataProvider();
            for each(_loc3_ in param2)
            {
               this._tokens.push(new TokenRendererVO(_loc3_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function get tokens() : DataProvider
      {
         return this._tokens;
      }
   }
}
