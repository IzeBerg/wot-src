package net.wg.gui.messenger.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ChannelMemberVO extends DAAPIDataClass
   {
       
      
      public var dbID:Number;
      
      public var userName:String = "";
      
      public var isOnline:Boolean = true;
      
      public var state:Number;
      
      public var isPlayerSpeaking:Boolean = false;
      
      public var tags:Array;
      
      public var color:uint;
      
      public function ChannelMemberVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this.tags)
         {
            this.tags.splice(0,this.tags.length);
            this.tags = null;
         }
         super.onDispose();
      }
   }
}
