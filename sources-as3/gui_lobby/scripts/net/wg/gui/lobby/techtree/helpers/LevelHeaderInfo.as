package net.wg.gui.lobby.techtree.helpers
{
   public class LevelHeaderInfo
   {
       
      
      public var start:Number;
      
      public var end:Number;
      
      public var level:int = 0;
      
      public function LevelHeaderInfo(param1:Number = 0, param2:Number = 0, param3:int = 0)
      {
         super();
         this.start = param1;
         this.end = param2;
         this.level = param3;
      }
      
      public function toString() : String
      {
         return "[LevelHeaderInfo: start = " + this.start + ", end = " + this.end + ", level = " + this.level + "]";
      }
   }
}
