package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ChainsPanelVO extends DAAPIDataClass
   {
      
      private static const CHAINS:String = "chains";
       
      
      private var _chains:Vector.<ChainButtonVO>;
      
      public function ChainsPanelVO(param1:Object)
      {
         this._chains = new Vector.<ChainButtonVO>();
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == CHAINS)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,CHAINS + Errors.CANT_NULL);
            for each(_loc4_ in _loc3_)
            {
               this._chains.push(new ChainButtonVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._chains)
         {
            _loc1_.dispose();
         }
         this._chains.splice(0,this._chains.length);
         this._chains = null;
         super.onDispose();
      }
      
      public function get chains() : Vector.<ChainButtonVO>
      {
         return this._chains;
      }
   }
}
