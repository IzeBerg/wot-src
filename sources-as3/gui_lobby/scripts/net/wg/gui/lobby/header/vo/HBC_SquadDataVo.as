package net.wg.gui.lobby.header.vo
{
   public class HBC_SquadDataVo extends HBC_AbstractVO
   {
      
      private static const SQUAD_EXTEND_INFO:String = "squadExtendInfoVo";
       
      
      public var buttonName:String = "#platoon:headerButton/squad";
      
      public var icon:String = "../maps/icons/battleTypes/40x40/squad.png";
      
      public var isEvent:Boolean = false;
      
      public var hasSearchSupport:Boolean = false;
      
      public var squadExtendInfoVo:ExtendedSquadInfoVo = null;
      
      public function HBC_SquadDataVo()
      {
         super();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == SQUAD_EXTEND_INFO)
         {
            this.squadExtendInfoVo = new ExtendedSquadInfoVo(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function set isInSquad(param1:Boolean) : void
      {
         this.buttonName = !!param1 ? PLATOON.HEADERBUTTON_INSQUAD : PLATOON.HEADERBUTTON_SQUAD;
      }
      
      override protected function onDispose() : void
      {
         this.squadExtendInfoVo.dispose();
         this.squadExtendInfoVo = null;
         super.onDispose();
      }
   }
}
