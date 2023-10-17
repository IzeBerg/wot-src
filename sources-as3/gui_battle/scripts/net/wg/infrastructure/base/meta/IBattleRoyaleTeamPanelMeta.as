package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleRoyaleTeamPanelMeta extends IEventDispatcher
   {
       
      
      function as_setInitData(param1:String, param2:Array, param3:Array) : void;
      
      function as_setPlayerState(param1:int, param2:Boolean, param3:Boolean, param4:int, param5:String, param6:String, param7:String) : void;
      
      function as_setPlayerStatus(param1:int, param2:Boolean, param3:Boolean, param4:Boolean) : void;
      
      function as_setPlayerHP(param1:int, param2:int) : void;
      
      function as_setPlayerFrags(param1:int, param2:String) : void;
      
      function as_setVehicleLevel(param1:int, param2:String) : void;
      
      function as_setPlayerVehicle(param1:int, param2:String) : void;
   }
}
