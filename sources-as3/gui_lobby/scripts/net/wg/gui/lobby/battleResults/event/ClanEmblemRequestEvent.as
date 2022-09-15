package net.wg.gui.lobby.battleResults.event
{
   import flash.events.Event;
   import net.wg.gui.lobby.battleResults.IEmblemLoadedDelegate;
   
   public class ClanEmblemRequestEvent extends Event
   {
      
      public static const TYPE:String = "ClanEmblemLoadEvent";
       
      
      public var uid:String;
      
      public var clanId:Number;
      
      public var delegate:IEmblemLoadedDelegate;
      
      public function ClanEmblemRequestEvent(param1:String, param2:Number, param3:IEmblemLoadedDelegate)
      {
         this.uid = param1;
         this.clanId = param2;
         this.delegate = param3;
         super(TYPE,true,true);
      }
   }
}
