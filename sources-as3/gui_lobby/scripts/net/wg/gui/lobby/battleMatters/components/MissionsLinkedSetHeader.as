package net.wg.gui.lobby.battleMatters.components
{
   import flash.text.TextField;
   import net.wg.gui.lobby.battleMatters.data.MissionLinkedSetHeaderVO;
   import net.wg.gui.lobby.missions.components.MissionPackHeaderBase;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class MissionsLinkedSetHeader extends MissionPackHeaderBase
   {
      
      private static const HEIGHT_OFFSET:int = 70;
      
      private static const TEXT_OFFSET:int = 18;
       
      
      public var infoTf:TextField = null;
      
      public function MissionsLinkedSetHeader()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.infoTf.mouseEnabled = false;
         mouseEnabled = false;
      }
      
      override protected function onDispose() : void
      {
         this.infoTf = null;
         super.onDispose();
      }
      
      private function updateContentWidth() : void
      {
         if(this.infoTf.visible)
         {
            this.infoTf.x = width - this.infoTf.width - TEXT_OFFSET;
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:MissionLinkedSetHeaderVO = null;
         super.draw();
         if(data && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = MissionLinkedSetHeaderVO(data);
            this.infoTf.visible = StringUtils.isNotEmpty(_loc1_.info);
            if(this.infoTf.visible)
            {
               this.infoTf.mouseEnabled = true;
               this.infoTf.htmlText = _loc1_.info;
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateContentWidth();
         }
      }
      
      override public function get height() : Number
      {
         return HEIGHT_OFFSET;
      }
      
      override protected function get dataClass() : Class
      {
         return MissionLinkedSetHeaderVO;
      }
   }
}
