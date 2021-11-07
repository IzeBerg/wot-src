package net.wg.gui.components.battleRoyale
{
   import flash.events.Event;
   
   public class ModuleConfiguratorEvent extends Event
   {
      
      public static const MODULE_OVER:String = "moduleOver";
      
      public static const MODULE_OUT:String = "moduleOut";
      
      public static const MODULE_CLICK:String = "moduleClick";
       
      
      private var _moduleIntCD:uint = 0;
      
      private var _columnIdx:int = -1;
      
      private var _moduleIdx:int = -1;
      
      public function ModuleConfiguratorEvent(param1:String, param2:uint, param3:int, param4:int, param5:Boolean = true, param6:Boolean = true)
      {
         super(param1,param5,param6);
         this._moduleIntCD = param2;
         this._columnIdx = param3;
         this._moduleIdx = param4;
      }
      
      public function get moduleIntCD() : uint
      {
         return this._moduleIntCD;
      }
      
      public function get columnIdx() : int
      {
         return this._columnIdx;
      }
      
      public function get moduleIdx() : int
      {
         return this._moduleIdx;
      }
      
      override public function clone() : Event
      {
         return new ModuleConfiguratorEvent(type,this.moduleIntCD,this.columnIdx,this.moduleIdx,bubbles,cancelable);
      }
   }
}
