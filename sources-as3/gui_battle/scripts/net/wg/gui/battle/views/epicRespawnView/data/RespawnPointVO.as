package net.wg.gui.battle.views.epicRespawnView.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RespawnPointVO extends DAAPIDataClass
   {
       
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var isEnemyNear:Boolean = false;
      
      public function RespawnPointVO(param1:Object)
      {
         super(param1);
      }
   }
}
