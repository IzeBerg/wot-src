package net.wg.gui.lobby.eventBoards.events
{
   import flash.events.Event;
   import net.wg.gui.lobby.eventBoards.data.AwardStripeRendererVO;
   
   public class AwardsRendererEvent extends Event
   {
      
      public static const AWARD_CHANGED:String = "awardChanged";
      
      public static const AWARD_POSITION_CHANGE:String = "awardPositionChange";
       
      
      private var _awardVO:AwardStripeRendererVO = null;
      
      private var _position:Number;
      
      public function AwardsRendererEvent(param1:String, param2:Number, param3:AwardStripeRendererVO, param4:Boolean = true, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this._awardVO = param3;
         this._position = param2;
      }
      
      public function get awardVO() : AwardStripeRendererVO
      {
         return this._awardVO;
      }
      
      public function get position() : Number
      {
         return this._position;
      }
      
      override public function clone() : Event
      {
         return new AwardsRendererEvent(type,this.position,this.awardVO);
      }
      
      override public function toString() : String
      {
         return formatToString("AwardsRendererEvent","type","position","awardVO","bubbles","cancelable");
      }
   }
}
