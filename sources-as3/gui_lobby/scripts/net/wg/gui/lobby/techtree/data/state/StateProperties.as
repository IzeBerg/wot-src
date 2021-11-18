package net.wg.gui.lobby.techtree.data.state
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class StateProperties implements IDisposable
   {
       
      
      public var id:uint;
      
      public var state:String;
      
      public var action:String;
      
      public var enough:uint;
      
      public var visible:Boolean;
      
      public var animation:AnimationProperties;
      
      public var cmpAlpha:Number;
      
      public var isEnabled:Boolean;
      
      public function StateProperties(param1:uint, param2:String, param3:String = "", param4:uint = 0, param5:Boolean = false, param6:AnimationProperties = null, param7:Number = 1, param8:Boolean = true)
      {
         super();
         this.id = param1;
         this.state = param2;
         this.action = param3;
         this.enough = param4;
         this.visible = param5;
         this.animation = param6;
         this.cmpAlpha = param7;
         this.isEnabled = param8;
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function toString() : String
      {
         return "[StateProperties] id=" + this.id + ", state=" + this.state + ", action=" + this.action + ", enough=" + this.enough + ", visible=" + this.visible + ", cmpAlpha=" + this.cmpAlpha;
      }
      
      protected function onDispose() : void
      {
         this.animation = null;
      }
   }
}
