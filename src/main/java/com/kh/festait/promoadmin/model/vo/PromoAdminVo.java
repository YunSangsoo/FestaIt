
package com.kh.festait.promoadmin.model.vo;

import com.kh.festait.common.model.vo.Image;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PromoAdminVo {

    private int promoId;
    private int appId;
    private String promoTitle;
    private String promoDetail;
    private Date createDate;
    private Date updateDate;
    private int views;

    private String promoWriter;
    private int writerUserNo;
    private String userStatus;

    private String promotionPageUrl;
    private String isPromoted;
    private Date startDate;
    private Date endDate;
    private String appTitle;

    private Image posterImage;
    private String posterPath;

    private int imgNo;
}