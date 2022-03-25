package net.wg.gui.battle.commander.views.common.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DAAPIPlayerPanelInfoVO extends DAAPIDataClass
   {
       
      
      public var name:String = "";
      
      public var nameVehicle:String = "";
      
      public var typeVehicle:String = "";
      
      public var hpMax:int = 0;
      
      public var hpCurrent:int = 0;
      
      public var vehID:uint = 0;
      
      public var team:uint = 0;
      
      public var isAlly:Boolean = false;
      
      public var isAlive:Boolean = false;
      
      public var isPlayer:Boolean = false;
      
      public var isCommander:Boolean = false;
      
      public var isObserver:Boolean = false;
      
      public var manner:int = 0;
      
      public var order:int = 0;
      
      public var groupID:int = 0;
      
      public var rosterIndex:int = 0;
      
      public var isBot:Boolean = false;
      
      public var iconPath:String = "";
      
      public var altIconPath:String = "";
      
      public function DAAPIPlayerPanelInfoVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
