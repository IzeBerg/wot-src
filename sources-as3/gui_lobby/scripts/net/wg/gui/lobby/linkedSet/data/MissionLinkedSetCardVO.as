package net.wg.gui.lobby.linkedSet.data
{
   import net.wg.gui.lobby.missions.data.MissionCardViewVO;
   
   public class MissionLinkedSetCardVO extends MissionCardViewVO
   {
       
      
      public var isCornerEnable:Boolean = false;
      
      public var isCornerChangedOnly:Boolean = false;
      
      public var uiPicture:String = "";
      
      public var checkStates:Array = null;
      
      public function MissionLinkedSetCardVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this.checkStates != null)
         {
            this.checkStates.splice(0,this.checkStates.length);
            this.checkStates = null;
         }
         super.onDispose();
      }
   }
}
