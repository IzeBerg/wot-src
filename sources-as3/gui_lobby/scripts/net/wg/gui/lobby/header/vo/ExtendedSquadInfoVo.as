package net.wg.gui.lobby.header.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ExtendedSquadInfoVo extends DAAPIDataClass
   {
       
      
      public var platoonState:String = "";
      
      public var squadManStates:Array = null;
      
      public var commanderIndex:int = 0;
      
      public function ExtendedSquadInfoVo(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this.squadManStates)
         {
            this.squadManStates.splice(0,this.squadManStates.length);
            this.squadManStates = null;
         }
         super.onDispose();
      }
   }
}
