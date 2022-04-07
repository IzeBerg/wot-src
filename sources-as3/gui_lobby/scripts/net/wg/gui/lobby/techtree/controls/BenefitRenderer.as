package net.wg.gui.lobby.techtree.controls
{
   import flash.text.TextField;
   import net.wg.gui.lobby.techtree.data.vo.BenefitRendererVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   
   public class BenefitRenderer extends UIComponentEx implements IUpdatable
   {
      
      public static const TILE_WIDTH:int = 120;
      
      public static const TILE_HEIGHT:int = 140;
       
      
      public var icon:IImage = null;
      
      public var labelTF:TextField = null;
      
      public function BenefitRenderer()
      {
         super();
      }
      
      public final function update(param1:Object) : void
      {
         this.setData(param1);
      }
      
      public function setData(param1:Object) : void
      {
         var _loc2_:BenefitRendererVO = BenefitRendererVO(param1);
         this.icon.source = _loc2_.iconSrc;
         this.labelTF.htmlText = _loc2_.labelStr;
         App.utils.commons.updateTextFieldSize(this.labelTF,false,true);
      }
      
      override protected function onDispose() : void
      {
         this.icon = null;
         this.labelTF = null;
         super.onDispose();
      }
   }
}
