package net.wg.gui.lobby.eventBoards.components
{
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.common.containers.CenterAlignedGroupLayout;
   import net.wg.gui.components.containers.IGroupEx;
   import net.wg.gui.lobby.eventBoards.data.TopPlayerAwardRendererVO;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   
   public class TopPlayerAwardRenderer extends BasePlayerAwardRenderer
   {
      
      private static const AWARD_RENDERER_WIDTH:Number = 48;
      
      private static const AWARD_RENDERER_HEIGHT:Number = 48;
      
      private static const AWARD_POSITION_X:int = 300;
      
      private static const AWARDS_GAP:int = 20;
       
      
      public var awardsGroup:IGroupEx;
      
      private var _rendererData:TopPlayerAwardRendererVO = null;
      
      public function TopPlayerAwardRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = true;
         this.awardsGroup.layout = new CenterAlignedGroupLayout(AWARD_RENDERER_WIDTH,AWARD_RENDERER_HEIGHT);
         this.awardsGroup.itemRendererLinkage = Linkages.AWARD_RENDERER;
      }
      
      override public function getData() : Object
      {
         return this._rendererData;
      }
      
      override public function setData(param1:Object) : void
      {
         if(param1 != null)
         {
            this._rendererData = TopPlayerAwardRendererVO(param1);
            invalidateData();
            super.setData(param1);
         }
      }
      
      override protected function draw() : void
      {
         if(this._rendererData && isInvalid(InvalidationType.DATA))
         {
            this.invalidateAwards();
            visible = true;
         }
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         this.awardsGroup.dispose();
         this.awardsGroup = null;
         this._rendererData = null;
         super.onDispose();
      }
      
      private function invalidateAwards() : void
      {
         this.awardsGroup.visible = false;
         CenterAlignedGroupLayout(this.awardsGroup.layout).gap = AWARDS_GAP;
         this.awardsGroup.dataProvider = this._rendererData.icons;
         var _loc1_:Number = (AWARD_RENDERER_WIDTH + AWARDS_GAP) * this.awardsGroup.getProviderLength();
         UIComponent(this.awardsGroup).setSize(_loc1_,AWARD_RENDERER_HEIGHT);
         this.awardsGroup.x = AWARD_POSITION_X;
         this.awardsGroup.visible = true;
      }
   }
}
