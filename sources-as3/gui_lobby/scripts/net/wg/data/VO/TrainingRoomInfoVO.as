package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   
   public class TrainingRoomInfoVO extends DAAPIDataClass
   {
      
      private static const BADGE_FIELD_NAME:String = "badgeVisualVO";
       
      
      public var comment:String = "";
      
      public var arenaName:String = "";
      
      public var roundLenString:String = "";
      
      public var maxPlayersCount:Number = 0;
      
      public var arenaSubType:String = "";
      
      public var creator:String = "";
      
      public var arenaTypeID:Number = 0;
      
      public var description:String = "";
      
      public var title:String = "";
      
      public var canChangeArenaVOIP:Boolean;
      
      public var isObserverModeEnabled:Boolean;
      
      public var arenaVoipChannels:Number = -1;
      
      public var isCreator:Boolean = false;
      
      public var battleTypeIco:String = "";
      
      public var creatorFullName:String = "";
      
      public var creatorClan:String = "";
      
      public var creatorRegion:String = "";
      
      public var creatorIgrType:int = 0;
      
      public var badge:int = 0;
      
      public var badgeImgStr:String = "";
      
      public var badgeVisualVO:BadgeVisualVO = null;
      
      public function TrainingRoomInfoVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == BADGE_FIELD_NAME)
         {
            this.badgeVisualVO = new BadgeVisualVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.badgeVisualVO)
         {
            this.badgeVisualVO.dispose();
            this.badgeVisualVO = null;
         }
         super.onDispose();
      }
   }
}
