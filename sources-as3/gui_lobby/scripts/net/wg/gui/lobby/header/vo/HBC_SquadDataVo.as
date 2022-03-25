package net.wg.gui.lobby.header.vo
{
   public class HBC_SquadDataVo extends HBC_AbstractVO
   {
      
      private static const SQUAD_EXTEND_INFO:String = "squadExtendInfoVo";
       
      
      public var buttonName:String = "#platoon:headerButton/squad";
      
      public var icon:String = "../maps/icons/battleTypes/40x40/squad.png";
      
      public var isEvent:Boolean = false;
      
      public var hasSearchSupport:Boolean = false;
      
      private var _squadExtendInfoVo:ExtendedSquadInfoVo = null;
      
      public function HBC_SquadDataVo()
      {
         super();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == SQUAD_EXTEND_INFO)
         {
            this._squadExtendInfoVo = new ExtendedSquadInfoVo(param2);
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
         if(this._squadExtendInfoVo)
         {
            this._squadExtendInfoVo.dispose();
            this._squadExtendInfoVo = null;
         }
         super.onDispose();
      }
      
      public function get squadExtendInfoVo() : ExtendedSquadInfoVo
      {
         return this._squadExtendInfoVo;
      }
      
      public function set squadExtendInfoVo(param1:ExtendedSquadInfoVo) : void
      {
         this._squadExtendInfoVo = param1;
      }
   }
}
